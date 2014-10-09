package com.game.login.message
{
    import net.*;

    public class ReqLoginForPlatformMessage extends Message
    {
        private var _serverId:String;
        private var _username:String;
        private var _agent:String;
        private var _ad:String;
        private var _time:String;
        private var _isadult:String;
        private var _sign:String;
        private var _localref:String;
        private var _reserva1:String;
        private var _reserva2:String;
        private var _logintype:String;
        private var _agentPlusdata:String;
        private var _agentColdatas:String;
        private var _adregtime:String;

        public function ReqLoginForPlatformMessage()
        {
            return;
        }// end function

        override protected function writing() : Boolean
        {
            writeString(this._serverId);
            writeString(this._username);
            writeString(this._agent);
            writeString(this._ad);
            writeString(this._time);
            writeString(this._isadult);
            writeString(this._sign);
            writeString(this._localref);
            writeString(this._reserva1);
            writeString(this._reserva2);
            writeString(this._logintype);
            writeString(this._agentPlusdata);
            writeString(this._agentColdatas);
            writeString(this._adregtime);
            return true;
        }// end function

        override protected function reading() : Boolean
        {
            this._serverId = readString();
            this._username = readString();
            this._agent = readString();
            this._ad = readString();
            this._time = readString();
            this._isadult = readString();
            this._sign = readString();
            this._localref = readString();
            this._reserva1 = readString();
            this._reserva2 = readString();
            this._logintype = readString();
            this._agentPlusdata = readString();
            this._agentColdatas = readString();
            this._adregtime = readString();
            return true;
        }// end function

        override public function getId() : int
        {
            return 100208;
        }// end function

        public function get serverId() : String
        {
            return this._serverId;
        }// end function

        public function set serverId(param1:String) : void
        {
            this._serverId = param1;
            return;
        }// end function

        public function get username() : String
        {
            return this._username;
        }// end function

        public function set username(param1:String) : void
        {
            this._username = param1;
            return;
        }// end function

        public function get agent() : String
        {
            return this._agent;
        }// end function

        public function set agent(param1:String) : void
        {
            this._agent = param1;
            return;
        }// end function

        public function get ad() : String
        {
            return this._ad;
        }// end function

        public function set ad(param1:String) : void
        {
            this._ad = param1;
            return;
        }// end function

        public function get time() : String
        {
            return this._time;
        }// end function

        public function set time(param1:String) : void
        {
            this._time = param1;
            return;
        }// end function

        public function get isadult() : String
        {
            return this._isadult;
        }// end function

        public function set isadult(param1:String) : void
        {
            this._isadult = param1;
            return;
        }// end function

        public function get sign() : String
        {
            return this._sign;
        }// end function

        public function set sign(param1:String) : void
        {
            this._sign = param1;
            return;
        }// end function

        public function get localref() : String
        {
            return this._localref;
        }// end function

        public function set localref(param1:String) : void
        {
            this._localref = param1;
            return;
        }// end function

        public function get reserva1() : String
        {
            return this._reserva1;
        }// end function

        public function set reserva1(param1:String) : void
        {
            this._reserva1 = param1;
            return;
        }// end function

        public function get reserva2() : String
        {
            return this._reserva2;
        }// end function

        public function set reserva2(param1:String) : void
        {
            this._reserva2 = param1;
            return;
        }// end function

        public function get logintype() : String
        {
            return this._logintype;
        }// end function

        public function set logintype(param1:String) : void
        {
            this._logintype = param1;
            return;
        }// end function

        public function get agentPlusdata() : String
        {
            return this._agentPlusdata;
        }// end function

        public function set agentPlusdata(param1:String) : void
        {
            this._agentPlusdata = param1;
            return;
        }// end function

        public function get agentColdatas() : String
        {
            return this._agentColdatas;
        }// end function

        public function set agentColdatas(param1:String) : void
        {
            this._agentColdatas = param1;
            return;
        }// end function

        public function get adregtime() : String
        {
            return this._adregtime;
        }// end function

        public function set adregtime(param1:String) : void
        {
            this._adregtime = param1;
            return;
        }// end function

    }
}
