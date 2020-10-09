#To be run as a gnuplot script as follows:

# $ gnuplot plotit.gp

#set terminal png enhanced size 1000
set terminal pngcairo size 1000, 450
set output "dailyusers.png"

#set xtics x/ntics

set style line 1 lw 2 lc rgb "red"
set style line 2 lw 2 lc rgb "black"
set style line 3 lw 2 lc rgb "green" 
set style line 4 lw 2 lc rgb "purple"
set style line 5 lw 2 lc rgb "orange"
set xlabel "days"
set ylabel "users"
set title "Daily Users"
set yrange [-1:200]
set xrange [0:34]
#set xtics nomirror autofreq scale 0 rotate by 250
set xtics scale 1 rotate by 250
set xtics 1,2
plot \
"daily_users.txt" u 2:xticlabel(1) w line ls 1 title "login1", \
"daily_users.txt" u 3 w line ls 2 title "login2", \
"daily_users.txt" u 4 w line ls 3 title "login3", \
"daily_users.txt" u 5 w line ls 4 title "login4", \
"daily_users.txt" u 6 w line ls 5 title "login5"

