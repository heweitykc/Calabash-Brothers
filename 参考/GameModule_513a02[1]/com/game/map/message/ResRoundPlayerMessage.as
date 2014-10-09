package com.game.map.message
{
    import com.game.map.bean.*;
    import net.*;

    public class ResRoundPlayerMessage extends Message
    {
        private var _player:CSPlayerInfo;

        public function ResRoundPlayerMessage()
        {
            return;
        }// end function

        override protected function writing() : Boolean
        {
            writeBean(this._player);
            return true;
        }// end function

        override protected function reading() : Boolean
        {
            this._player = readBean(CSPlayerInfo) as CSPlayerInfo;
            return true;
        }// end function

        override public function getId() : int
        {
            return 101101;
        }// end function

        public function get player() : CSPlayerInfo
        {
            return this._player;
        }// end function

        public function set player(param1:CSPlayerInfo) : void
        {
            this._player = param1;
            return;
        }// end function

    }
}
