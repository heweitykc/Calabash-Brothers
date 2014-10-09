package com.game.magicbook.bean
{
    import net.*;

    public class MagicAttrInfo extends Bean
    {
        private var _attrId:int;
        private var _attrValue:int;
        private var _attrValueBefor:int;

        public function MagicAttrInfo()
        {
            return;
        }// end function

        public function set attrId(param1:int) : void
        {
            this._attrId = param1;
            return;
        }// end function

        public function get attrId() : int
        {
            return this._attrId;
        }// end function

        public function set attrValue(param1:int) : void
        {
            this._attrValue = param1;
            return;
        }// end function

        public function get attrValue() : int
        {
            return this._attrValue;
        }// end function

        public function set attrValueBefor(param1:int) : void
        {
            this._attrValueBefor = param1;
            return;
        }// end function

        public function get attrValueBefor() : int
        {
            return this._attrValueBefor;
        }// end function

        override public function getId() : int
        {
            return 0;
        }// end function

        override protected function writing() : Boolean
        {
            writeInt(this._attrId);
            writeInt(this._attrValue);
            writeInt(this._attrValueBefor);
            return true;
        }// end function

        override protected function reading() : Boolean
        {
            this._attrId = readInt();
            this._attrValue = readInt();
            this._attrValueBefor = readInt();
            return true;
        }// end function

    }
}
