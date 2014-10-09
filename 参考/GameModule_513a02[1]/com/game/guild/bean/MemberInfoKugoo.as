package com.game.guild.bean
{
    import com.game.utils.*;
    import net.*;

    public class MemberInfoKugoo extends Bean
    {
        private var _loginID:String;
        private var _userId:long;
        private var _userName:String;
        private var _pos:int;

        public function MemberInfoKugoo()
        {
            return;
        }// end function

        override protected function writing() : Boolean
        {
            writeString(this.loginID);
            writeLong(this.userId);
            writeString(this.userName);
            writeInt(this.pos);
            return true;
        }// end function

        override protected function reading() : Boolean
        {
            this.loginID = readString();
            this.userId = readLong();
            this.userName = readString();
            this.pos = readInt();
            return true;
        }// end function

        public function get loginID() : String
        {
            return this._loginID;
        }// end function

        public function set loginID(param1:String) : void
        {
            this._loginID = param1;
            return;
        }// end function

        public function get userId() : long
        {
            return this._userId;
        }// end function

        public function set userId(param1:long) : void
        {
            this._userId = param1;
            return;
        }// end function

        public function get userName() : String
        {
            return this._userName;
        }// end function

        public function set userName(param1:String) : void
        {
            this._userName = param1;
            return;
        }// end function

        public function get pos() : int
        {
            return this._pos;
        }// end function

        public function set pos(param1:int) : void
        {
            this._pos = param1;
            return;
        }// end function

    }
}
