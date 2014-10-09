package com.game.realm.message
{
    import com.game.realm.bean.*;
    import net.*;

    public class ResIntensifyToClientMessage extends Message
    {
        private var _bealmInfo:RealmInfo;
        private var _result:int;
        private var _prompt:String;

        public function ResIntensifyToClientMessage()
        {
            return;
        }// end function

        override protected function writing() : Boolean
        {
            writeBean(this._bealmInfo);
            writeInt(this._result);
            writeString(this._prompt);
            return true;
        }// end function

        override protected function reading() : Boolean
        {
            this._bealmInfo = readBean(RealmInfo) as RealmInfo;
            this._result = readInt();
            this._prompt = readString();
            return true;
        }// end function

        override public function getId() : int
        {
            return 158103;
        }// end function

        public function get bealmInfo() : RealmInfo
        {
            return this._bealmInfo;
        }// end function

        public function set bealmInfo(param1:RealmInfo) : void
        {
            this._bealmInfo = param1;
            return;
        }// end function

        public function get result() : int
        {
            return this._result;
        }// end function

        public function set result(param1:int) : void
        {
            this._result = param1;
            return;
        }// end function

        public function get prompt() : String
        {
            return this._prompt;
        }// end function

        public function set prompt(param1:String) : void
        {
            this._prompt = param1;
            return;
        }// end function

    }
}
