package com.game.player.message
{
    import __AS3__.vec.*;
    import com.game.utils.*;
    import net.*;

    public class ResChangePlayerEnemiesToClientMessage extends Message
    {
        protected var _enemies:Vector.<long>;

        public function ResChangePlayerEnemiesToClientMessage()
        {
            this._enemies = new Vector.<long>;
            return;
        }// end function

        override protected function writing() : Boolean
        {
            return true;
        }// end function

        override protected function reading() : Boolean
        {
            var _loc_1:* = readShort();
            var _loc_2:* = 0;
            while (_loc_2 < _loc_1)
            {
                
                this._enemies.push(readLong());
                _loc_2++;
            }
            return true;
        }// end function

        override public function getId() : int
        {
            return 511401;
        }// end function

        public function get enemies() : Vector.<long>
        {
            return this._enemies;
        }// end function

        public function set enemies(param1:Vector.<long>) : void
        {
            this._enemies = param1;
            return;
        }// end function

    }
}
