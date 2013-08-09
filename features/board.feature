Feature: Board

	Scenario: A new board
		Given a new chess board
		Then the board should look like
		"""
		r n b q k b n r
		p p p p p p p p
		. . . . . . . .
		. . . . . . . .
		. . . . . . . .
		. . . . . . . .
		P P P P P P P P
		R N B Q K B N R
		"""
