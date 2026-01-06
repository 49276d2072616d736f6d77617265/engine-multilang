package body Core is

   function Initialize return Engine_State is
      S : Engine_State;
   begin
      S.Counter := 0;
      return S;
   end Initialize;

   procedure Step (S : in out Engine_State) is
   begin
      S.Counter := S.Counter + 1;
   end Step;

   function Value (S : Engine_State) return Integer is
   begin
      return S.Counter;
   end Value;

end Core;
