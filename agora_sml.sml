local
fun printResult(x:Int64.int, y:int)=print(Int64.toString(x) ^ " " ^ Int.toString(y)^"\n");

fun gcd (c:Int64.int, 0:Int64.int):Int64.int= c
|gcd(0:Int64.int,d:Int64.int):Int64.int= d
|gcd(c:Int64.int,d:Int64.int):Int64.int  = gcd (d:Int64.int,(c mod d));

fun lcm(a:Int64.int,1:Int64.int):Int64.int= a
| 	lcm(1:Int64.int,b:Int64.int):Int64.int= b
|	lcm(a:Int64.int,b:Int64.int):Int64.int = (a div (gcd( a, b))) * b ;


fun listLcm(acc:Int64.int, []:Int64.int list):Int64.int=acc
    |listLcm (acc:Int64.int, x::t:Int64.int list):Int64.int = 
    listLcm(lcm(acc,x):Int64.int, t:Int64.int list) ;
    
fun aheadLcm (x::t:Int64.int list, n:int, acc:Int64.int) = if(n-1<0) then acc 
else aheadLcm(t , n-1,lcm(x,acc));

(* fun prevLcm (x::b::t:int list, n:int, acc:int) = if(n=0) then acc  *)
(* else prevLcm((x::b):int list , n-1,lcm(t,acc)); *)

fun leastLcm(x::t:Int64.int list, n:int,all:int):Int64.int=
    lcm(aheadLcm(x::t,n,1),aheadLcm( rev (x::t),all-n,1));


fun main(x::t:Int64.int list, n:int,all:int,acc:Int64.int, sel:int)= 
    if(n-1<0) then (acc,sel)
        else	
            if (acc > leastLcm(x::t:Int64.int list,n,all)) then main(x::t:Int64.int list,n-1,all,leastLcm(x::t:Int64.int list,n,all),n+1)
            else main(x::t:Int64.int list,n-1,all,acc,sel);


in

fun agora file = 
    let val inStream = TextIO.openIn file
        val N = Option.valOf (TextIO.scanStream (Int.scan StringCvt.DEC) inStream)
        
        fun crlist lis 0 = lis
        |	crlist lis num = crlist (Int64.fromInt (Option.valOf (TextIO.scanStream (Int.scan StringCvt.DEC) inStream))::lis) (num-1)
        val arr = rev(crlist [] N)
    in
        (* dist a (rmax (rev a) []) 0 0 0 *)
        (* print(Int.toString(N)) *)
        printResult (main(arr,N-1,N-1,leastLcm(arr,N-1,N-1),0))
    
    end;
    
end    