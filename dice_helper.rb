module DiceString
  def self.roll n
    lambda{Random.rand(n) + 1}
  end

  class DiceNode < Treetop::Runtime::SyntaxNode
    def evaluate
      n = num_dice.text_value == "" ? 1 : num_dice.evaluate
      s = sides.text_value == '%' ? 100 : sides.evaluate
      rolls = ([Dice.roll(s)]*n).map(&:call)
      rolls = keep.evaluate(rolls) if keep.text_value != ""
      rolls.inject(0){|v,l| v += l}
    end
  end

  class BinopNode < Treetop::Runtime::SyntaxNode
    def evaluate
      tail.elements.inject(head.evaluate) do |value, element| 
        element.operator.apply(value, element.operand.evaluate)
      end
    end
  end

  class KeepNode < Treetop::Runtime::SyntaxNode
    def evaluate rolls
      case op.text_value
      when 'h', 'k'
        rolls.sort.reverse.take n.evaluate
      when 'l'
        rolls.sort.take n.evaluate
      else
        rolls
      end
    end 
  end 
end