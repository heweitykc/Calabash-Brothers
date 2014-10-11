package com.game.country.bean
{
    import net.*;

    public class AwardInfo extends Bean
    {
        private var _type:int;
        private var _count:int;

        public function AwardInfo()
        {
            return;
        }// end function

        public function set type(param1:int) : void
        {
            this._type = param1;
            return;
        }// end function

        public function get type() : int
        {
            return this._type;
        }// end function

        public function set count(param1:int) : void
        {
            this._count = param1;
            return;
        }// end function

        public function get count() : int
        {
            return this._count;
        }// end function

        override public function getId() : int
        {
            return 0;
        }// end function

        override protected function writing() : Boolean
        {
            writeInt(this._type);
            writeInt(this._count);
            return true;
        }// end function

        override protected function reading() : Boolean
        {
            this._type = readInt();
            this._count = readInt();
            return true;
        }// end function

    }
}
