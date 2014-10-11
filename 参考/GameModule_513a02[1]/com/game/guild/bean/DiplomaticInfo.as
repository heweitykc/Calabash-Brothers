package com.game.guild.bean
{
    import com.game.utils.*;
    import net.*;

    public class DiplomaticInfo extends Bean
    {
        private var _guildId:long;
        private var _diplomaticTime:int;

        public function DiplomaticInfo()
        {
            return;
        }// end function

        override protected function writing() : Boolean
        {
            writeLong(this._guildId);
            writeInt(this._diplomaticTime);
            return true;
        }// end function

        override protected function reading() : Boolean
        {
            this._guildId = readLong();
            this._diplomaticTime = readInt();
            return true;
        }// end function

        public function get guildId() : long
        {
            return this._guildId;
        }// end function

        public function set guildId(param1:long) : void
        {
            this._guildId = param1;
            return;
        }// end function

        public function get diplomaticTime() : int
        {
            return this._diplomaticTime;
        }// end function

        public function set diplomaticTime(param1:int) : void
        {
            this._diplomaticTime = param1;
            return;
        }// end function

    }
}
