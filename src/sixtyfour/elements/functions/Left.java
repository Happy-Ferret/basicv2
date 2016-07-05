/*
 * 
 */
package sixtyfour.elements.functions;

import java.util.List;

import sixtyfour.elements.Type;
import sixtyfour.parser.Atom;
import sixtyfour.parser.Parser;
import sixtyfour.system.Machine;
import sixtyfour.util.VarUtils;

/**
 * The Class Left.
 */
public class Left extends AbstractFunction {
	
	/**
	 * Instantiates a new left.
	 */
	public Left() {
		super("LEFT$");
	}

	/* (non-Javadoc)
	 * @see sixtyfour.parser.Atom#getType()
	 */
	@Override
	public Type getType() {
		return Type.STRING;
	}

	/* (non-Javadoc)
	 * @see sixtyfour.parser.Atom#eval(sixtyfour.system.Machine)
	 */
	@Override
	public Object eval(Machine machine) {
		try {
			List<Atom> pars = Parser.getParameters(term);
			if (pars.size() != 2) {
				throw new RuntimeException("Wrong number of parameters: " + term);
			}
			Atom var = pars.get(0);
			int count = VarUtils.getInt(pars.get(1).eval(machine));
			String txt = var.eval(machine).toString();

			try {
				return txt.substring(0, count < txt.length() ? count : txt.length());
			} catch (Exception e) {
				throw new RuntimeException("Illegal quantity error: " + txt + "/" + count);
			}
		} catch (Throwable t) {
			throw new RuntimeException("Syntax error: " + term);
		}
	}

}