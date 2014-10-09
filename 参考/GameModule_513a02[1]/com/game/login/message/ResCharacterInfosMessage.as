package com.game.login.message
{
    import __AS3__.vec.*;
    import com.game.login.bean.*;
    import net.*;

    public class ResCharacterInfosMessage extends Message
    {
        private var _characters:Vector.<CharacterInfo>;

        public function ResCharacterInfosMessage()
        {
            this._characters = new Vector.<CharacterInfo>;
            return;
        }// end function

        override protected function writing() : Boolean
        {
            var _loc_1:* = 0;
            writeShort(this._characters.length);
            _loc_1 = 0;
            while (_loc_1 < this._characters.length)
            {
                
                writeBean(this._characters[_loc_1]);
                _loc_1++;
            }
            return true;
        }// end function

        override protected function reading() : Boolean
        {
            var _loc_1:* = 0;
            var _loc_2:* = readShort();
            _loc_1 = 0;
            while (_loc_1 < _loc_2)
            {
                
                this._characters[_loc_1] = readBean(CharacterInfo) as CharacterInfo;
                _loc_1++;
            }
            return true;
        }// end function

        override public function getId() : int
        {
            return 100101;
        }// end function

        public function get characters() : Vector.<CharacterInfo>
        {
            return this._characters;
        }// end function

        public function set characters(param1:Vector.<CharacterInfo>) : void
        {
            this._characters = param1;
            return;
        }// end function

    }
}
