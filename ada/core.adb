with System;

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

   function State_Size return Natural is
   begin
      return Engine_State'Size / System.Storage_Unit;
   end State_Size;

end Core;
