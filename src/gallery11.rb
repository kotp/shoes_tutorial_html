# gallery11.rb
# Kohonen's Self Organizing Feature Maps
# http://www.ai-junkie.com/ann/som/som1.html
N = 20
W = 20

Shoes.app :width => 400, :height => 450, :title => 'Self Organizing Map v0.1' do
  nostroke
  @nodes = []
  
  def base_color
    [rand(256), rand(256), rand(256)]
  end
  
  def mix node, *rgb
    r0, g0, b0 = rgb
    x, y = node.left / W, node.top / W
    [y - 1, y, y +1].each do |j|
      [x - 1, x, x + 1].each do |i|
        begin
          n = j * N + i
          r, g, b = @nodes[n].style[:color]
          #r, g, b = (r + r0) / 2, (g + g0) / 2, (b + b0) / 2
          r, g, b = r + (r0 - r) / 5, g + (g0 - g) / 5, b + (b0 - b) / 5
          @nodes[n].fill = rgb(r, g, b)
          @nodes[n].style :color => [r, g, b]
          @nodes[n].show
        end unless (i == -1 or i == N or j == -1 or j == N)
      end
    end
  end
  
  def som
    r0, g0, b0 = base_color
    node = @nodes.sort_by do |n|
      r, g, b = n.style[:color]
      ::Math::sqrt((r - r0) * (r - r0) + (g - g0) * (g - g0) + (b - b0) * (b - b0))
    end.shift
    
    mix node, r0, g0, b0
  end
  
  N.times do |j|
    N.times do |i|
      r, g, b = base_color
      @nodes << rect(i*W, j*W, W, W, :fill => rgb(r, g, b), :color => [r, g, b])
    end
  end
  
  msg  = para 0, :left => 100, :top => 420
  
  button 'start', :left => 20, :top => 420 do
    animate(36){|i| som; msg.text = i}
  end
end
