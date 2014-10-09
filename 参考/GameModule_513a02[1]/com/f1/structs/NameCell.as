package com.f1.structs
{

    public class NameCell extends Object
    {
        public var txtName:String = "";
        public var className:String = "";
        public var needFlow:Boolean = true;

        public function NameCell(param1:String = "", param2:String = "", param3:Boolean = true)
        {
            this.txtName = param1;
            this.className = param2;
            this.needFlow = param3;
            return;
        }// end function

    }
}
