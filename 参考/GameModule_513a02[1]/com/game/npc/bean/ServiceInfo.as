package com.game.npc.bean
{
    import net.*;

    public class ServiceInfo extends Bean
    {
        private var _serviceId:int;
        private var _serviceName:String;
        private var _serviceParameter:String;

        public function ServiceInfo()
        {
            return;
        }// end function

        override protected function writing() : Boolean
        {
            writeInt(this._serviceId);
            writeString(this._serviceName);
            writeString(this._serviceParameter);
            return true;
        }// end function

        override protected function reading() : Boolean
        {
            this._serviceId = readInt();
            this._serviceName = readString();
            this._serviceParameter = readString();
            return true;
        }// end function

        public function get serviceId() : int
        {
            return this._serviceId;
        }// end function

        public function set serviceId(param1:int) : void
        {
            this._serviceId = param1;
            return;
        }// end function

        public function get serviceName() : String
        {
            return this._serviceName;
        }// end function

        public function set serviceName(param1:String) : void
        {
            this._serviceName = param1;
            return;
        }// end function

        public function get serviceParameter() : String
        {
            return this._serviceParameter;
        }// end function

        public function set serviceParameter(param1:String) : void
        {
            this._serviceParameter = param1;
            return;
        }// end function

    }
}
