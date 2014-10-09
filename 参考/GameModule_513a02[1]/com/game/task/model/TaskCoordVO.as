package com.game.task.model
{
    import com.adobe.serialization.json.*;

    public class TaskCoordVO extends Object
    {
        public var taskId:int;
        public var id:int;
        public var num:int;
        public var mapId:int;
        public var x:int;
        public var y:int;
        public var autoFind:int = 1;
        public var info:String;
        public var type:int = 0;
        public var kind:int;

        public function TaskCoordVO()
        {
            return;
        }// end function

        public function parse(param1:String) : void
        {
            var _loc_2:* = param1.split("_", 2);
            this.id = _loc_2[0];
            this.num = _loc_2[1];
            var _loc_3:* = param1.indexOf("{") + 1;
            var _loc_4:* = param1.indexOf("}");
            var _loc_5:* = param1.substring(_loc_3, _loc_4);
            var _loc_6:* = _loc_5.split("_");
            this.mapId = int(_loc_6[0]);
            this.x = int(_loc_6[1]);
            this.y = int(_loc_6[2]);
            return;
        }// end function

        public function parseJS(param1:String) : void
        {
            var _loc_2:* = JSON.decode(param1);
            this.taskId = _loc_2.taskId;
            this.id = _loc_2.id;
            this.num = _loc_2.num;
            this.mapId = _loc_2.mapId;
            this.x = _loc_2.x;
            this.y = _loc_2.y;
            this.type = _loc_2.type;
            this.kind = _loc_2.kind;
            return;
        }// end function

        public function toString() : String
        {
            var _loc_1:* = {};
            _loc_1.taskId = this.taskId;
            _loc_1.id = this.id;
            _loc_1.num = this.num;
            _loc_1.mapId = this.mapId;
            _loc_1.x = this.x;
            _loc_1.y = this.y;
            _loc_1.type = this.type;
            _loc_1.kind = this.kind;
            return JSON.encode(_loc_1);
        }// end function

    }
}
