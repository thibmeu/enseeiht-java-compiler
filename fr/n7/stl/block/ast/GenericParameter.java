package fr.n7.stl.block.ast;

import java.util.List;

/**
 * @author Marc Pantel
 *
 */
public interface GenericParameter extends Declaration {


	/**
	 * Synthesized semantics attribute for the type of the declared variable.
	 * @return Type of the declared variable.
	 */
    Type getType();

    List<GenericType> getInheritance();
}
