package com.sixtyfour.basicshell;

import java.awt.BorderLayout;
import java.awt.Color;
import java.awt.Dimension;
import java.awt.FlowLayout;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;
import java.awt.event.KeyAdapter;
import java.awt.event.KeyEvent;
import java.io.File;
import java.util.concurrent.ArrayBlockingQueue;
import java.util.concurrent.ExecutorService;
import java.util.concurrent.Executors;

import javax.swing.JButton;
import javax.swing.JFrame;
import javax.swing.JLabel;
import javax.swing.JPanel;
import javax.swing.JScrollPane;
import javax.swing.JTextArea;
import javax.swing.SwingUtilities;
import javax.swing.WindowConstants;
import javax.swing.event.CaretEvent;
import javax.swing.event.CaretListener;
import javax.swing.text.BadLocationException;

import com.sixtyfour.Basic;
import com.sixtyfour.util.Colors;

/**
 * A simple shell for loading/editing and running BASIC programs.
 * 
 * @author nietoperz809
 */
public class BasicShell {
	static final ExecutorService executor = Executors.newFixedThreadPool(10);
	private final ArrayBlockingQueue<String> fromTextArea = new ArrayBlockingQueue<>(20);
	private final ArrayBlockingQueue<String> toTextArea = new ArrayBlockingQueue<>(20);
	private JTextArea mainTextArea;
	private JPanel panel1;
	private JButton stopButton;
	private JButton clsButton;
	private JButton runButton;
	private Runner runner = null;
	private ProgramStore store = new ProgramStore();
	private int[] lastStrLen = new int[2]; // Length of last output chunk
	private int rowNum; // line number set by caret listener
	private int colNum; // column number "
	private JLabel caretLabel;

	/**
	 * Main thread entry point
	 */
	public static void main(String[] unused) {
		System.setProperty("sun.java2d.d3d", "false"); // To make it work on my
														// Radeon HD 290X...;-)
		JFrame frame = new JFrame("Commodore BASIC V2");
		frame.setIconImage(ResourceLoader.getIcon());
		BasicShell shellFrame = new BasicShell();
		frame.setContentPane(shellFrame.panel1);
		frame.setDefaultCloseOperation(WindowConstants.EXIT_ON_CLOSE);
		frame.pack();
		frame.setVisible(true);
		shellFrame.putString("COMMODORE BASIC V2\n" + ProgramStore.OK);

		try // increase GUI responsiveness
		{
			SwingUtilities.invokeAndWait(new Runnable() {
				public void run() {
					Thread.currentThread().setPriority(Thread.MAX_PRIORITY);
				}
			});
		} catch (Exception e) {
			e.printStackTrace();
		}
		shellFrame.commandLoop();
	}

	/**
	 * Returns length of the output string before the last one Needed by some input
	 * statements
	 * 
	 * @return Lengh of penultimate output
	 */
	int getPenultimateOutputSize() {
		return lastStrLen[0];
	}

	private BasicShell() {
		setupUI();
		mainTextArea.addCaretListener(new CaretListener() {
			@Override
			public void caretUpdate(CaretEvent e) {
				JTextArea editArea = (JTextArea) e.getSource();
				try {
					int caretpos = editArea.getCaretPosition();
					rowNum = editArea.getLineOfOffset(caretpos);
					colNum = caretpos - editArea.getLineStartOffset(rowNum);
					caretLabel.setText("  " + rowNum + " - " + colNum);
				} catch (Exception ex) {
					ex.printStackTrace();
				}
			}
		});
		mainTextArea.addKeyListener(new KeyAdapter() {
			@Override
			public void keyReleased(KeyEvent e) {
				if (e.getKeyChar() == '\n') {
					try {
						fromTextArea.put(getLineAt(rowNum - 1));
					} catch (InterruptedException e1) {
						e1.printStackTrace();
					}
				}
				if (runner != null) {
					runner.registerKey(null);
				}
				super.keyReleased(e);
			}

			@Override
			public void keyPressed(KeyEvent e) {
				if (runner != null) {
					runner.registerKey(e.getKeyChar());
				}
				super.keyPressed(e);
			}
		});

		executor.execute(new Runnable() {
			@Override
			public void run() {
				int cnt = 0;
				while (true) {
					try {
						String s = toTextArea.take();
						mainTextArea.append(s);
						mainTextArea.setCaretPosition(mainTextArea.getDocument().getLength());
						if (runner != null && runner.getRunningBasic() != null
								&& runner.getRunningBasic().isRunning()) {
							if ((cnt++) % 1000 == 0) {
								Thread.sleep(1);
							}
						}
						Thread.yield();

						if (mainTextArea.getText().length() > 100000) {
							mainTextArea
									.setText(mainTextArea.getText().substring(mainTextArea.getText().length() - 70000));
						}

					} catch (InterruptedException e) {
						e.printStackTrace();
					}
				}
			}
		});
		stopButton.addActionListener(new ActionListener() {
			@Override
			public void actionPerformed(ActionEvent e) {
				if (runner != null) {
					Basic i = runner.getRunningBasic();
					if (i != null) {
						i.runStop();
					}
				}
			}
		});
		clsButton.addActionListener(new ActionListener() {
			@Override
			public void actionPerformed(ActionEvent e) {
				cls();
			}
		});

		runButton.addActionListener(new ActionListener() {
			@Override
			public void actionPerformed(ActionEvent e) {
				run(false);
			}
		});
	}

	/**
	 * Method generated by IntelliJ IDEA GUI Designer
	 */
	private void setupUI() {
		panel1 = new JPanel();
		panel1.setLayout(new BorderLayout(0, 0));
		final JPanel panel2 = new JPanel();
		panel2.setLayout(new FlowLayout(FlowLayout.LEFT, 2, 2));
		panel2.setBackground(Color.BLACK);
		panel2.setPreferredSize(new Dimension(800, 34));
		panel1.add(panel2, BorderLayout.SOUTH);
		stopButton = new JButton();
		stopButton.setText("STOP");
		stopButton.setPreferredSize(new Dimension(82, 30));
		panel2.add(stopButton);
		clsButton = new JButton();
		clsButton.setPreferredSize(new Dimension(82, 30));
		clsButton.setText("CLS");
		panel2.add(clsButton);
		runButton = new JButton();
		runButton.setPreferredSize(new Dimension(82, 30));
		runButton.setText("RUN");
		panel2.add(runButton);
		caretLabel = new JLabel();
		caretLabel.setPreferredSize(new Dimension(82, 30));
		caretLabel.setForeground(Color.pink);
		panel2.add(caretLabel);
		mainTextArea = new ShellTextComponent(this);
		mainTextArea.setCaretColor(new Color(Colors.COLORS[14]));
		final JScrollPane scrollPane1 = new JScrollPane(mainTextArea);

		panel1.add(scrollPane1, BorderLayout.CENTER);
		panel1.setPreferredSize(new Dimension(800, 600));
	}

	/**
	 * Return line at specified position
	 * 
	 * @param linenum Line number
	 * @return Line as String
	 */
	private String getLineAt(int linenum) {
		try {
			int start = mainTextArea.getLineStartOffset(linenum);
			int end = mainTextArea.getLineEndOffset(linenum);
			return mainTextArea.getText(start, end - start);
		} catch (BadLocationException e) {
			return ("");
		}
	}

	/**
	 * Wipe text area
	 */
	private void cls() {
		mainTextArea.setText("");
	}

	private void run(boolean sync) {
		runner = new Runner(store.toArray(), this);
		runner.start(sync);
	}

	/**
	* 
	*/
	private void dir() {
		File[] filesInFolder = new File(".").listFiles();
		if (filesInFolder != null) {
			for (File fileEntry : filesInFolder) {
				if (fileEntry.isFile()) {
					putString(fileEntry.getName() + " -- " + fileEntry.length() + '\n');
				}
			}
		}
	}

	/**
	 * Send text to text area. Blocks thd caller if buffer is full
	 * 
	 * @param outText
	 */
	public void putString(String outText) {
		try {
			toTextArea.put(outText);
			lastStrLen[0] = lastStrLen[1];
			lastStrLen[1] = outText.length();
		} catch (InterruptedException e) {
			e.printStackTrace();
		}
	}

	/**
	 * @param outText
	 */
	public void putStringUCase(String outText) {
		putString(outText.toUpperCase());
	}

	/**
	 * Command loop that runs in main thread
	 */
	private void commandLoop() {
		while (true) {
			String s = getString();
			String sl = s.toLowerCase();
			if (sl.startsWith("load") || sl.startsWith("save")) {
				s = s.replace("\"", " ").trim();
			}
			String[] split = s.split(" ");
			if (sl.equals("list")) {
				putString(store.toString());
			} else if (sl.equals("new")) {
				store.clear();
			} else if (sl.equals("cls")) {
				cls();
			} else if (sl.equals("dir")) {
				dir();
			} else if (sl.equals("run")) {
				if (runner != null) {
					runner.dispose();
				}
				runner = new Runner(store.toArray(), this);
				runner.synchronousStart();
			} else if (split[0].toLowerCase().equals("save")) {
				String msg = store.save(split[1]);
				putString(msg);
			} else if (split[0].toLowerCase().equals("load")) {
				String msg = store.load(split[1]);
				putString(msg);
			} else {
				if (!store.insert(s)) {
					if (runner == null) {
						runner = new Runner(new String[] {}, this);
					}
					try {
						runner.executeDirectCommand(s);
					} catch (Throwable t) {
						putString("?ERROR\n");
					}
				}
			}
		}
	}

	public ProgramStore getStore() {
		return store;
	}

	/**
	 * Get input from text area. Blocks the caller if there is none
	 * 
	 * @return
	 */
	public String getString() {
		try {
			return fromTextArea.take().trim();
		} catch (InterruptedException e) {
			e.printStackTrace();
			return null;
		}
	}

	public boolean peek() {
		return fromTextArea.peek() != null;
	}
}
