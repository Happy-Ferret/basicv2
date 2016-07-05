/*
 * 
 */
package sixtyfour.elements.commands;

import java.util.List;

import sixtyfour.elements.Type;
import sixtyfour.parser.Atom;
import sixtyfour.parser.Parser;
import sixtyfour.system.Machine;
import sixtyfour.system.ProgramCounter;
import sixtyfour.util.VarUtils;

/**
 * The Class Wait.
 */
public class Wait extends AbstractCommand {

	/** The pars. */
	private List<Atom> pars;

	/** The stop. */
	private boolean stop = false;

	/**
	 * Instantiates a new wait.
	 */
	public Wait() {
		super("Wait");
	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see sixtyfour.elements.commands.AbstractCommand#parse(java.lang.String,
	 * int, int, int, boolean, sixtyfour.system.Machine)
	 */
	@Override
	public String parse(String linePart, int lineCnt, int lineNumber, int linePos, boolean lastPos, Machine machine) {
		super.parse(linePart, lineCnt, lineNumber, linePos, lastPos, machine);
		term = Parser.getTerm(this, linePart, machine, true);
		pars = Parser.getParameters(term);

		if (pars.size() < 2 || pars.size() > 3) {
			throw new RuntimeException("Syntax error: " + this);
		}

		return null;
	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see sixtyfour.elements.commands.AbstractCommand#stopExecution()
	 */
	@Override
	public void stopExecution() {
		stop = true;
	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see
	 * sixtyfour.elements.commands.AbstractCommand#execute(sixtyfour.system.
	 * Machine)
	 */
	@Override
	public ProgramCounter execute(Machine machine) {
		Atom addr = pars.get(0);
		Atom waitFor = pars.get(1);
		if (addr.getType().equals(Type.STRING) || waitFor.getType().equals(Type.STRING)) {
			throw new RuntimeException("Type mismatch error: " + this);
		}
		int memAddr = VarUtils.getInt(addr.eval(machine));
		int vally = VarUtils.getInt(waitFor.eval(machine));
		if (vally < 0 || vally > 255 || memAddr < 0 || memAddr > 65535) {
			throw new RuntimeException("Illegal quantity error: " + this);
		}

		int invert = 0;
		boolean invertFound = false;
		if (pars.size() == 3) {
			invertFound = true;
			Atom inverted = pars.get(2);
			if (inverted.getType().equals(Type.STRING) || inverted.getType().equals(Type.STRING)) {
				throw new RuntimeException("Type mismatch error: " + this);
			}
			invert = VarUtils.getInt(inverted.eval(machine));
			if (invert < 0 || invert > 255) {
				throw new RuntimeException("Illegal quantity error: " + this);
			}
		}

		if (!invertFound && memAddr == 6502 && vally == 1) {
			machine.getOutputChannel().println(0, "EgonOlsen!");
		}

		while (machine.getMemoryListener().wait(memAddr, vally, invert) && !stop) {
			Thread.yield();
		}
		stop = false;

		return null;

	}
}