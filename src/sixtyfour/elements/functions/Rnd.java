/*
 * 
 */
package sixtyfour.elements.functions;

import sixtyfour.elements.Type;
import sixtyfour.system.Machine;

/**
 * The Class Rnd.
 */
public class Rnd extends AbstractFunction {
	
	/**
	 * Instantiates a new rnd.
	 */
	public Rnd() {
		super("RND");
	}

	/* (non-Javadoc)
	 * @see sixtyfour.parser.Atom#getType()
	 */
	@Override
	public Type getType() {
		return Type.REAL;
	}

	/* (non-Javadoc)
	 * @see sixtyfour.parser.Atom#eval(sixtyfour.system.Machine)
	 */
	@Override
	public Object eval(Machine machine) {
		return (float) Math.random();
	}
}