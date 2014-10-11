package com.game.summonpet.bean
{
    import net.*;

    public class SummonPetAttribute extends Bean
    {
        private var _type:int;
        private var _value:int;

        public function SummonPetAttribute()
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

        public function set value(param1:int) : void
        {
            this._value = param1;
            return;
        }// end function

        public function get value() : int
        {
            return this._value;
        }// end function

        override public function getId() : int
        {
            return 0;
        }// end function

        override protected function writing() : Boolean
        {
            writeInt(this._type);
            writeInt(this._value);
            return true;
        }// end function

        override protected function reading() : Boolean
        {
            this._type = readInt();
            this._value = readInt();
            return true;
        }// end function

    }
}
