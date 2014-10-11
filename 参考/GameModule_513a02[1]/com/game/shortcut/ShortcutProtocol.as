package com.game.shortcut
{
    import com.*;
    import com.game.shortcut.message.*;
    import com.game.utils.*;

    public class ShortcutProtocol extends BaseProtocol
    {

        public function ShortcutProtocol()
        {
            return;
        }// end function

        public function addShortCutHandle(param1:int, param2:long, param3:int, param4:int) : void
        {
            var _loc_5:* = new AddShortCutMessage();
            _loc_5.shortcutGrid = param1;
            _loc_5.shortcutSource = param2;
            _loc_5.shortcutSourceModel = param3;
            _loc_5.shortcutType = param4;
            send(_loc_5);
            return;
        }// end function

        public function removeShortCutHandle(param1:long) : void
        {
            var _loc_2:* = new RemoveShortCutMessage();
            _loc_2.shortcutId = param1;
            send(_loc_2);
            return;
        }// end function

        public function moveShortCutHandle(param1:int, param2:long) : void
        {
            var _loc_3:* = new MoveShortCutMessage();
            _loc_3.shortcutGrid = param1;
            _loc_3.shortcutId = param2;
            send(_loc_3);
            return;
        }// end function

    }
}
