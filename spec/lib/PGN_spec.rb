require 'spec_helper'

describe PGN do
  before do
    @pgn = PGN.new "#{Rails.root}/spec/test.pgn"
  end

  it 'parses correctly' do
    @pgn.event.should eql("F/S Return Match")
    @pgn.site.should eql("Belgrade, Serbia Yugoslavia|JUG")
    @pgn.date.should eql("1992.11.04")
    @pgn.round.should eql("29")
    @pgn.white.should eql("Fischer, Robert J.")
    @pgn.black.should eql("Spassky, Boris V.")
    @pgn.result.should eql("1/2-1/2")
    @pgn.moves.should eql(["e4", "e5", "Nf3", "Nc6", "Bb5", "..", "a6", "Ba4", "Nf6", "O-O", "Be7", "Re1", "b5", "Bb3", "d6", "c3", "O-O", "h3", 
                           "Nb8", "d4", "Nbd7", "c4", "c6", "cxb5", "axb5", "Nc3", "Bb7", "Bg5", "b4", "Nb1", "h6", "Bh4", "c5", "dxe5", "Nxe4", 
                           "Bxe7", "Qxe7", "exd6", "Qf6", "Nbd2", "Nxd6", "Nc4", "Nxc4", "Bxc4", "Nb6", "Ne5", "Rae8", "Bxf7+", "Rxf7", "Nxf7", 
                           "Rxe1+", "Qxe1", "Kxf7", "Qe3", "Qg5", "Qxg5", "hxg5", "b3", "Ke6", "a3", "Kd6", "axb4", "cxb4", "Ra5", "Nd5", "f3", "Bc8", 
                           "Kf2", "Bf5", "Ra7", "g6", "Ra6+", "Kc5", "Ke1", "Nf4", "g3", "Nxh3", "Kd2", "Kb5", "Rd6", "Kc5", "Ra6", "Nf2", "g4", "Bd3", "Re6"])
  end

end
