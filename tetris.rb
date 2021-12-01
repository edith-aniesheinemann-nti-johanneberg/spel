require "gosu"



class Tetris < Gosu::Window
    def initialize 
        @max_y = 10
        @max_x = 7
        super @max_x * 37, @max_y * 37
        self.caption = "Tetris the Game"
        @blocks = []
        @blocks << Block.new
        @direction = nil
    end

    def button_down(id)
        if id == Gosu::KB_RIGHT
            @direction = :right
        elsif id == Gosu::KB_LEFT
            @direction = :left
        end
        if id == Gosu::KB_DOWN
            @direction = :down
        end
    end

    def update

        last = @blocks.last

        if @direction == :right
            last.move_right
        elsif  @direction == :left
            last.move_left
        end
        if @direction == :down
            last.speed_fall
        end

        @direction = nil

        last.fall
        @blocks.each do |block|
            if block.cell_y == last.cell_y + 1 && block.cell_x == last.cell_x || last.cell_y == @max_y - 1
                last.stop!
            end
            # Skriv kod som gör att blocket "byter sida" när den förflyttar sig utanför skärmen
        end
        if last.stopped?
            @blocks << Block.new
        end

    end

    def draw
        @blocks.each do |block|
            block.draw
        end
    end
end

class Block

     def initialize
        @image = Gosu::Image.new("media/tetris_block.png")
        @score = 0
        @x = 37 * 2
        @y = 0
        @falling = true
    end
    
    def cell_y
        @y / 37
    end

    def cell_x
        @x / 37
    end

    def move_right
        @x += 37
    end

    def move_left
        @x -= 37
    end

    def speed_fall
       @y += 37
    end 

    def draw
        @image.draw(cell_x * 37, cell_y * 37)
        @image.draw(cell_x * 37, (cell_y-1) * 37)
    end

    def fall
        if @falling
            @y += 1
        end
    end

    def stop!
        @falling = false
    end

    def stopped?
        return @falling == false
    end
end

Tetris.new.show