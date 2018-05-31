function love.load()

    love.window.setMode( 800, 500)
    love.window.setTitle( "Jogo estrategia" )

    white = love.graphics.newImage( "white.png" )
    black = love.graphics.newImage( "black.png" )
    size = 20
end

function love.update(dt)

end

function love.draw()
    printMap()
end

function printMap()
    for x = 0,39,1 do
        for y = 0,24,1 do
            if ( (x + y) % 2 == 0)
            then
                love.graphics.draw(black, x*size, y*size)
            else
                love.graphics.draw(white, x*size, y*size)
            end
        end
    end
end


