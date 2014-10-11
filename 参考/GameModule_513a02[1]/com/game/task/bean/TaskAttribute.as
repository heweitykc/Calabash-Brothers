package com.game.task.bean
{
    import net.*;

    public class TaskAttribute extends Bean
    {
        private var _model:int;
        private var _num:int;

        public function TaskAttribute()
        {
            return;
        }// end function

        override protected function writing() : Boolean
        {
            writeInt(this._model);
            writeInt(this._num);
            return true;
        }// end function

        override protected function reading() : Boolean
        {
            this._model = readInt();
            this._num = readInt();
            return true;
        }// end function

        public function get model() : int
        {
            return this._model;
        }// end function

        public function set model(param1:int) : void
        {
            this._model = param1;
            return;
        }// end function

        public function get num() : int
        {
            return this._num;
        }// end function

        public function set num(param1:int) : void
        {
            this._num = param1;
            return;
        }// end function

    }
}
