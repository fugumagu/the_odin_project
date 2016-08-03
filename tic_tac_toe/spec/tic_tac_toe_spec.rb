require 'tic_tac_toe'

describe Game do 

	context 'initial setup' do 
		it 'creates a blank board' do
			expect(subject.board).to eq([[" ", " ", " "], [" ", " ", " "], [" ", " ", " "]])
		end
	end
end