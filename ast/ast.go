package ast

import "gitlab.com/alexruf/monkey/token"

type Node interface {
	TokenLiteral() string
}

type Statement interface {
	Node
	statementNode()
}

type Expression interface {
	Node
	expressionNode()
}

type Program struct {
	Statements []Statement
}

func (p *Program) TokenLiteral() string {
	if len(p.Statements) > 0 {
		return p.Statements[0].TokenLiteral()
	} else {
		return ""
	}
}

type LetStatement struct {
	Token token.Token
	Name  *Indentifier
	Value Expression
}

func (ls *LetStatement) statementNode()       {}
func (ls *LetStatement) TokenLiteral() string { return ls.Token.Literal }

type Indentifier struct {
	Token token.Token
	Value string
}

func (i *Indentifier) expressionNode()      {}
func (i *Indentifier) TokenLiteral() string { return i.Token.Literal }
