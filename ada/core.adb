package body Core is

   procedure Initialize (S : out Engine_State) is
   begin
      S.Counter := 0;
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
