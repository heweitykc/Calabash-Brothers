package msg
{
    public class ReqLoginMessage extends Message
    {
        private var _serverId:int;
        private var _name:String;
        private var _password:String;

        public function ReqLoginMessage()
        {
            return;
        }// end function

        override protected function writing() : Boolean
        {
            writeInt(this._serverId);
            writeString(this._name);
            writeString(this._password);
            return true;
        }// end function

        override protected function reading() : Boolean
        {
            this._serverId = readInt();
            this._name = readString();
            this._password = readString();
            return true;
        }// end function

        override public function getId() : int
        {
            return 100201;
        }// end function

        public function get serverId() : int
        {
            return this._serverId;
        }// end function

        public function set serverId(param1:int) : void
        {
            this._serverId = param1;
            return;
        }// end function

        public function get name() : String
        {
            return this._name;
        }// end function

        public function set name(param1:String) : void
        {
            this._name = param1;
            return;
        }// end function

        public function get password() : String
        {
            return this._password;
        }// end function

        public function set password(param1:String) : void
        {
            this._password = param1;
            return;
        }// end function

    }
}
