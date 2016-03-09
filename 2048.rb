# -*- coding: utf-8 -*-

def set_field
  #2次元配列を宣言
  ##map! { Array.new } で各要素を、それぞれ別の「空っぽArray」インスタンスに置き換えている。
  $field = Array.new(4).map! { Array.new }
  
  for i in 0..3 do
    for j in 0..3 do
      $field[i][j] = 0 
    end
  end

#最初にどっかに2つ数字を代入する
  2.times{
    x, y = find_zero
    $field[x][y] = [2, 4].sample
  }
end

#メイン処理ループ
def mainloop
  while $field.min != 0 do
    #キーボードから入力を求める   
    case gets.chomp

    when 'w' #↑
      move_up2
    when 'a' #←
      move_left2
    when 's' #↓
      move_under2
    when 'd' #→
      move_right2
    when '0'
      break
    else
      next
    end

    #0の場所を探す
    x, y = find_zero
    if(x < 0 || y < 0)
      break
    end
#多分ここの2048変えれば終了条件変わる
    if($field.max.max >= 2048)

      print "すごい\n\n"
      show_field
      break
    end
#毎回移動するたびにどこかに数字を沸かせる
    $field[x][y] = [2, 4].sample
    
#表示させる
    show_field
    
  end
  print "GAME OVER! \n\n"
end

#fieldの配列から0の場所を探す
#左上から右にむかって1段目0?3, 2段目4?7...という感じで右下が15になる数え方 
def find_zero
  n = []
  for i in 0..3 do
    for j in 0..3 do
      if($field[i][j] == 0)
        n << i*4 + j
      end
    end
  end
#拾ってきた0の場所をランダムに選んで座標を返す
  m = n.sample
#ちなみにもし0がなかったらゲームオーバー　負の値を返す
  if(m == nil)
    return -1, -1
  elsif(m < 4)
    return 0, m%4
  elsif(m >= 4 && m < 8)
    return 1, m%4
  elsif(m >= 8 && m < 12)
    return 2, m%4
  elsif(m >= 12 && m < 16)
    return 3, m%4
  end
#一応保険多分↓要らない
  return -1, -1
end

def move_up2
  for j in 0..3 do
    hoge = []
    for i in 0..3 do
      hoge << $field[i][j]
    end
    
    hoge2 = hoge_sort(hoge, j)

    for i in 0..3 do
      $field[i][j] = hoge2[i]
    end
  end  
end

def move_left2
  for j in 0..3 do
    hoge = []
    for i in 0..3 do
      hoge << $field[j][i]
    end

    hoge2 = hoge_sort(hoge, j)

    for i in 0..3 do
      $field[j][i] = hoge2[i]
    end
  end  
end

def move_under2
  for j in 0..3 do
    hoge = []
    for i in 0..3 do
      hoge << $field[3-i][j]
    end

    hoge2 = hoge_sort(hoge, j)

    for i in 0..3 do
      $field[3-i][j] = hoge2[i]
    end
  end  
end

def move_right2
  for j in 0..3 do
    hoge = []
    for i in 0..3 do
      hoge << $field[3-j][3-i]
    end

    hoge2 = hoge_sort(hoge, j)

    for i in 0..3 do
      $field[3-j][3-i] = hoge2[i]
    end 

  end

end

def hoge_sort(hoge, j)

    hoge.delete(0)
    while hoge[3] == nil do
      hoge << 0
    end

    for i in 1..3 do
      if(hoge[i] == 0)
        next

      elsif(hoge[i] == hoge[i-1])
        hoge[i-1] = hoge[i-1]*2
        hoge[i] = 0
      elsif(hoge[i-1] == 0)
        hoge[i-1], hoge[i] = hoge[i], hoge[i-1]
      end
    end
  return hoge  
end

def show_field
system "clear"
  for i in 0..3 do
    for j in 0..3 do
      print "#{$field[i][j]}\t"
    end
    puts "\n"
  end
 puts "\n\n"
end