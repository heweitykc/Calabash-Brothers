package com.game.map.handler
{
    import com.f1.utils.*;
    import com.game.map.control.*;
    import com.game.map.message.*;
    import net.*;

    public class ResSendLinesHandler extends Handler
    {

        public function ResSendLinesHandler()
        {
            return;
        }// end function

        override public function action() : void
        {
            var _loc_5:* = null;
            var _loc_1:* = ResSendLinesMessage(this.message);
            var _loc_2:* = _loc_1.lines.length;
            var _loc_3:* = new Array();
            var _loc_4:* = 0;
            _loc_5 = new Array();
            var _loc_6:* = 0;
            while (_loc_6 < _loc_2)
            {
                
                _loc_3.push(_loc_1.lines[_loc_6]);
                _loc_5.push({line:_loc_1.lines[_loc_6], num:_loc_1.numbers[_loc_6]});
                _loc_4 = _loc_1.numbers[_loc_6] + _loc_4;
                Log.log(">>GameLines:" + _loc_1.lines[_loc_6] + "线[" + _loc_1.numbers[_loc_6] + "]");
                _loc_6 = _loc_6 + 1;
            }
            _loc_5.sortOn("line", Array.NUMERIC);
            MapControl.getInstance().updateLines(_loc_5, _loc_4);
            return;
        }// end function

    }
}
