package com.game.realm.message
{
    import com.game.realm.bean.*;
    import net.*;

    public class ResRealmInfoToClientMessage extends Message
    {
        private var _bealmInfo:RealmInfo;

        public function ResRealmInfoToClientMessage()
        {
            return;
        }// end function

        override protected function writing() : Boolean
        {
            writeBean(this._bealmInfo);
            return true;
        }// end function

        override protected function reading() : Boolean
        {
            this._bealmInfo = readBean(RealmInfo) as RealmInfo;
            return true;
        }// end function

        override public function getId() : int
        {
            return 158101;
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

    }
}
