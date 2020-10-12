require_relative 'tic_tac_toe'

class TicTacToeNode
  attr_reader :board, :next_mover_mark, :prev_move_pos

  def initialize(board, next_mover_mark, prev_move_pos = nil)
    @board = board
    @next_mover_mark = next_mover_mark
    @prev_move_pos = prev_move_pos
  end

  def losing_node?(evaluator)
    if self.board.over? 
      return self.board.winner != evaluator && self.board.winner != nil
    end
    children = self.children
    if evaluator == next_mover_mark
      children.all? do |child|
        child.losing_node?(evaluator)
      end
    else
      children.any? do |child|
        child.losing_node?(evaluator)
      end
    end
    
  end

  def winning_node?(evaluator)
    if self.board.over? 
      return self.board.winner == evaluator 
    end

    if evaluator == next_mover_mark
      children.any? do |child|
      child.winning_node?(evaluator)
      end
    else
      children.all? do |child|
      child.winning_node?(evaluator)
      end
    end
  end

  # This method generates an array of all moves that can be made after
  # the current move.
  def children
    arr = []
    board.rows.each_with_index do |row, i|
      row.each_with_index do |ele, j|
        if board.empty?([i,j])
          cur_board = board.dup 
          cur_board[[i,j]] = next_mover_mark
          if next_mover_mark == :o
            next_mark = :x
          else
            next_mark = :o
          end
          node = TicTacToeNode.new(cur_board, next_mark, [i,j])
          arr << node
        end
      end
    end
    arr
  end
end
