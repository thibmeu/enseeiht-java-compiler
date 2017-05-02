package fr.n7.stl.block.ast.impl;

import fr.n7.stl.block.ast.InheritanceDeclaration;
import fr.n7.stl.block.ast.Type;

/**
 * Created by thibault on 02/05/17.
 */
public class InheritanceDeclarationImpl implements InheritanceDeclaration {

    private String name;
    //TODO: type
    private Object type;

    public InheritanceDeclarationImpl(String _name, Object _type) {
        this.name = _name;
        this.type = _type;
    }

    /**
     * Provide the identifier (i.e. name) given to the declaration.
     *
     * @return Name of the declaration.
     */
    @Override
    public String getName() {
        return this.name;
    }

    /**
     * Synthesized semantics attribute for the type of the declared variable.
     *
     * @return Type of the declared variable.
     */
    @Override
    public Type getType() {
        return null;
    }
}
