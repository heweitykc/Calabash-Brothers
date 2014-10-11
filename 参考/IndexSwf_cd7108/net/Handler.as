package net
{

    public class Handler extends Object
    {
        protected var message:Message;
        protected var parameter:Object;
        protected var createTime:Number;

        public function Handler()
        {
            return;
        }// end function

        public function clone() : Object
        {
            return super.clone();
        }// end function

        public function getMessage() : Message
        {
            return this.message;
        }// end function

        public function setMessage(param1:Message) : void
        {
            this.message = param1;
            return;
        }// end function

        public function getParameter() : Object
        {
            return this.parameter;
        }// end function

        public function setParameter(param1:Object) : void
        {
            this.parameter = param1;
            return;
        }// end function

        public function getCreateTime() : Number
        {
            return this.createTime;
        }// end function

        public function setCreateTime(param1:Number) : void
        {
            this.createTime = param1;
            return;
        }// end function

        public function action() : void
        {
            return;
        }// end function

    }
}
