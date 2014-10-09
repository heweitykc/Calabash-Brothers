package com.game.historymsg.message
{
    import __AS3__.vec.*;
    import com.game.utils.*;
    import net.*;

    public class HistorymsgMessage extends Message
    {

        public function HistorymsgMessage()
        {
            return;
        }// end function

        protected function writeInts(param1:Vector.<int>) : void
        {
            var _loc_3:* = 0;
            var _loc_2:* = param1 == null ? (0) : (param1.length);
            writeShort(_loc_2);
            if (_loc_2 > 0)
            {
                for each (_loc_3 in param1)
                {
                    
                    writeInt(_loc_3);
                }
            }
            return;
        }// end function

        protected function readInts() : Vector.<int>
        {
            var _loc_1:* = new Vector.<int>;
            _loc_1.length = readShort();
            var _loc_2:* = 0;
            while (_loc_2 < _loc_1.length)
            {
                
                _loc_1[_loc_2] = readInt();
                _loc_2++;
            }
            return _loc_1;
        }// end function

        protected function writeLongs(param1:Vector.<long>) : void
        {
            var _loc_3:* = null;
            var _loc_2:* = param1 == null ? (0) : (param1.length);
            writeShort(_loc_2);
            if (_loc_2 > 0)
            {
                for each (_loc_3 in param1)
                {
                    
                    writeLong(_loc_3);
                }
            }
            return;
        }// end function

        protected function readLongs() : Vector.<long>
        {
            var _loc_1:* = new Vector.<long>;
            _loc_1.length = readShort();
            var _loc_2:* = 0;
            while (_loc_2 < _loc_1.length)
            {
                
                _loc_1[_loc_2] = readLong();
                _loc_2++;
            }
            return _loc_1;
        }// end function

        protected function readBeans(param1, param2:Class)
        {
            param1.length = readShort();
            var _loc_3:* = 0;
            while (_loc_3 < param1.length)
            {
                
                param1[_loc_3] = readBean(param2);
                _loc_3++;
            }
            return param1;
        }// end function

    }
}
