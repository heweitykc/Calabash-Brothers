package com.game.challenge.bean
{
    import net.*;

    public class ChallengeInfo extends Bean
    {
        private var _zonesnum:int;
        private var _bosstime:String;
        private var _gongchengtime:String;
        private var _lingditime:String;
        private var _epalacenum:String;
        private var _jiaochangnum:int;
        private var _doubletime:String;
        private var _mazetime:String;
        private var _biwudaotime:String;

        public function ChallengeInfo()
        {
            return;
        }// end function

        override protected function writing() : Boolean
        {
            writeInt(this._zonesnum);
            writeString(this._bosstime);
            writeString(this._gongchengtime);
            writeString(this._lingditime);
            writeString(this._epalacenum);
            writeInt(this._jiaochangnum);
            writeString(this._doubletime);
            writeString(this._mazetime);
            writeString(this._biwudaotime);
            return true;
        }// end function

        override protected function reading() : Boolean
        {
            this._zonesnum = readInt();
            this._bosstime = readString();
            this._gongchengtime = readString();
            this._lingditime = readString();
            this._epalacenum = readString();
            this._jiaochangnum = readInt();
            this._doubletime = readString();
            this._mazetime = readString();
            this._biwudaotime = readString();
            return true;
        }// end function

        public function get zonesnum() : int
        {
            return this._zonesnum;
        }// end function

        public function set zonesnum(param1:int) : void
        {
            this._zonesnum = param1;
            return;
        }// end function

        public function get bosstime() : String
        {
            return this._bosstime;
        }// end function

        public function set bosstime(param1:String) : void
        {
            this._bosstime = param1;
            return;
        }// end function

        public function get gongchengtime() : String
        {
            return this._gongchengtime;
        }// end function

        public function set gongchengtime(param1:String) : void
        {
            this._gongchengtime = param1;
            return;
        }// end function

        public function get lingditime() : String
        {
            return this._lingditime;
        }// end function

        public function set lingditime(param1:String) : void
        {
            this._lingditime = param1;
            return;
        }// end function

        public function get epalacenum() : String
        {
            return this._epalacenum;
        }// end function

        public function set epalacenum(param1:String) : void
        {
            this._epalacenum = param1;
            return;
        }// end function

        public function get jiaochangnum() : int
        {
            return this._jiaochangnum;
        }// end function

        public function set jiaochangnum(param1:int) : void
        {
            this._jiaochangnum = param1;
            return;
        }// end function

        public function get doubletime() : String
        {
            return this._doubletime;
        }// end function

        public function set doubletime(param1:String) : void
        {
            this._doubletime = param1;
            return;
        }// end function

        public function get mazetime() : String
        {
            return this._mazetime;
        }// end function

        public function set mazetime(param1:String) : void
        {
            this._mazetime = param1;
            return;
        }// end function

        public function get biwudaotime() : String
        {
            return this._biwudaotime;
        }// end function

        public function set biwudaotime(param1:String) : void
        {
            this._biwudaotime = param1;
            return;
        }// end function

    }
}
