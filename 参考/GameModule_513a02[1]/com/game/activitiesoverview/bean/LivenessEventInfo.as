package com.game.activitiesoverview.bean
{
    import net.*;

    public class LivenessEventInfo extends Bean
    {
        private var _type:int;
        private var _count:int;

        public function LivenessEventInfo()
        {
            return;
        }// end function

        public function get count() : int
        {
            return this._count;
        }// end function

        public function set count(param1:int) : void
        {
            this._count = param1;
            return;
        }// end function

        public function get type() : int
        {
            return this._type;
        }// end function

        public function set type(param1:int) : void
        {
            this._type = param1;
            return;
        }// end function

        override protected function writing() : Boolean
        {
            writeShort(this._type);
            writeShort(this._count);
            return true;
        }// end function

        override protected function reading() : Boolean
        {
            this._type = readShort();
            this._count = readShort();
            return true;
        }// end function

    }
}
