package com.game.guildflag.message
{
    import __AS3__.vec.*;
    import com.game.guildflag.bean.*;
    import net.*;

    public class ResOpenGuildFlagToClientMessage extends Message
    {
        private var _challengeInfo:Vector.<GuildFlagInfo>;
        private var _status:String;

        public function ResOpenGuildFlagToClientMessage()
        {
            this._challengeInfo = new Vector.<GuildFlagInfo>;
            return;
        }// end function

        override protected function writing() : Boolean
        {
            var _loc_1:* = 0;
            writeShort(this._challengeInfo.length);
            _loc_1 = 0;
            while (_loc_1 < this._challengeInfo.length)
            {
                
                writeBean(this._challengeInfo[_loc_1]);
                _loc_1++;
            }
            writeString(this._status);
            return true;
        }// end function

        override protected function reading() : Boolean
        {
            var _loc_1:* = 0;
            var _loc_2:* = readShort();
            _loc_1 = 0;
            while (_loc_1 < _loc_2)
            {
                
                this._challengeInfo[_loc_1] = readBean(GuildFlagInfo) as GuildFlagInfo;
                _loc_1++;
            }
            this._status = readString();
            return true;
        }// end function

        override public function getId() : int
        {
            return 149101;
        }// end function

        public function get challengeInfo() : Vector.<GuildFlagInfo>
        {
            return this._challengeInfo;
        }// end function

        public function set challengeInfo(param1:Vector.<GuildFlagInfo>) : void
        {
            this._challengeInfo = param1;
            return;
        }// end function

        public function get status() : String
        {
            return this._status;
        }// end function

        public function set status(param1:String) : void
        {
            this._status = param1;
            return;
        }// end function

    }
}
