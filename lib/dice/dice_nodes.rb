module DiceString
  class DiceNode < Treetop::Runtime::SyntaxNode
    def evaluate
      n = num_dice.text_value == "" ? 1 : num_dice.evaluate
      s = sides.text_value == '%' ? 100 : sides.evaluate
      rolls = Array.new(n){ Dice.rng.call(s) }
      sum rolls
    end

    def maximum
      n = num_dice.text_value == "" ? 1 : num_dice.evaluate
      s = sides.text_value == '%' ? 100 : sides.evaluate
      rolls = Array.new(n){ s }
      sum rolls
    end

    def minimum
      n = num_dice.text_value == "" ? 1 : num_dice.evaluate
      rolls = Array.new(n){ 1 }
      sum rolls
    end

  private
    def sum rolls
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

    def maximum
      tail.elements.inject(head.maximum) do |value, element|
        element.operator.apply(value, element.operand.maximum)
      end
    end

    def minimum
      tail.elements.inject(head.minimum) do |value, element|
        element.operator.apply(value, element.operand.minimum)
      end
    end
  end

  class KeepNode < Treetop::Runtime::SyntaxNode
    def evaluate rolls
      case op.text_value
      when 'h'
        rolls.sort.reverse.take n.evaluate
      when 'l'
        rolls.sort.take n.evaluate
      else
        rolls
      end
    end
  end
end
