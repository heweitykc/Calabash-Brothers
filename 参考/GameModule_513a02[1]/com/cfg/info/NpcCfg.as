package com.cfg.info
{
    import com.staticdata.*;

    public class NpcCfg extends Object
    {
        public var _npcId:int;
        public var _npcModelId:int;
        public var _npcName:String;
        public var _npcRes:String;
        public var _npcIcon:String;
        public var _dir:int;
        public var _x:int;
        public var _y:int;
        public var _acquisition_item:int;
        public var _map:int;
        public var _shop:String;
        public var _dialog:String;
        public var _type:int;
        public var q_sound:String;
        public var q_head:String;
        public var _function:String;

        public function NpcCfg()
        {
            return;
        }// end function

        public function parse(param1:Object) : void
        {
            this._npcModelId = param1.q_id;
            this._npcName = param1.q_name;
            this._npcRes = param1.q_resource;
            this._npcIcon = Params.ROLE_HEAD_PATH + param1.q_resource + ".png";
            this._dir = param1.q_direction;
            this._x = param1.q_x;
            this._y = param1.q_y;
            this._acquisition_item = param1.q_acquisition_item;
            this._map = param1.q_map;
            this._shop = param1.q_shop;
            this._function = param1.q_function;
            this._dialog = param1.q_dialog;
            this._type = param1.q_type;
            this.q_sound = param1.q_sound;
            this.q_head = param1.q_head;
            return;
        }// end function

    }
}
