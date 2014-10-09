package com.model.vo
{

    public class PageCountInfo extends Object
    {
        public var page:int;
        public var direct:int;

        public function PageCountInfo(param1:int, param2:int)
        {
            this.direct = param1;
            this.page = param2;
            return;
        }// end function

    }
}
