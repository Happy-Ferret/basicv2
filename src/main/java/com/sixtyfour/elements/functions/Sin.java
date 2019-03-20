package com.sixtyfour.elements.functions;

import com.sixtyfour.elements.Type;
import com.sixtyfour.system.Machine;
import com.sixtyfour.util.VarUtils;

/**
 * The SIN function.
 */
public class Sin extends AbstractFunction {

	/**
	 * Instantiates a new sin.
	 */
	public Sin() {
		super("SIN");
	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see sixtyfour.parser.Atom#getType()
	 */
	@Override
	public Type getType() {
		return Type.REAL;
	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see sixtyfour.parser.Atom#eval(sixtyfour.system.Machine)
	 */
	@Override
	public Object eval(Machine machine) {
		if (!term.getType().equals(Type.STRING)) {
			return Float.valueOf((float) Math.sin(VarUtils.getFloat(term.eval(machine))));
		}
		throw new RuntimeException("Type mismatch error: " + term.getType());
	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see com.sixtyfour.elements.functions.AbstractFunction#toCode(com.sixtyfour
	 * .system.Machine)
	 */
	@Override
	public String toCode(Machine machine) {
		String inter = term.toCode(machine);
		if (inter == null) {
			return null;
		}
		return "(float) Math.sin(" + inter + ")";
	}

}
