package com.game.monster.bean
{
    import com.game.utils.*;
    import net.*;

    public class TeamMemberDamage extends Bean
    {
        private var _memberName:String;
        private var _damage:int;
        private var _personid:long;

        public function TeamMemberDamage()
        {
            return;
        }// end function

        public function set memberName(param1:String) : void
        {
            this._memberName = param1;
            return;
        }// end function

        public function get memberName() : String
        {
            return this._memberName;
        }// end function

        public function set damage(param1:int) : void
        {
            this._damage = param1;
            return;
        }// end function

        public function get damage() : int
        {
            return this._damage;
        }// end function

        public function set personid(param1:long) : void
        {
            this._personid = param1;
            return;
        }// end function

        public function get personid() : long
        {
            return this._personid;
        }// end function

        override public function getId() : int
        {
            return 0;
        }// end function

        override protected function writing() : Boolean
        {
            writeString(this._memberName);
            writeInt(this._damage);
            writeLong(this._personid);
            return true;
        }// end function

        override protected function reading() : Boolean
        {
            this._memberName = readString();
            this._damage = readInt();
            this._personid = readLong();
            return true;
        }// end function

    }
}
