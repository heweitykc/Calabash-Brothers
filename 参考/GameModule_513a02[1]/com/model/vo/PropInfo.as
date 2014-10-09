package com.model.vo
{
    import __AS3__.vec.*;
    import com.cfg.info.*;
    import com.cfg.obj.*;
    import com.game.backpack.bean.*;
    import com.game.utils.*;
    import com.staticdata.*;
    import com.util.*;
    import flash.net.*;
    import flash.utils.*;

    public class PropInfo extends ItemCfg
    {
        protected var _itemId:long;
        protected var _itemModelId:int;
        protected var _shortcutId:long;
        protected var _num:Number = 0;
        protected var _gridId:int;
        protected var _isbind:int;
        protected var _addAttributLevel:int;
        protected var _attribute:int;
        protected var _isFullAppend:int;
        protected var _lostTime:int;
        protected var _lockedEndTime:int;
        protected var _q_type:int;
        protected var _q_str_limit:int;
        protected var _q_agile_limit:int;
        protected var _q_drop:int;
        protected var _q_drop_confirm:Boolean;
        protected var _q_shortcut:int;
        protected var _q_bind:int;
        protected var _q_max:int;
        protected var _q_buy_price:int;
        protected var _q_sell:int;
        protected var _q_sell_price:int;
        protected var _q_sell_confirm:Boolean;
        protected var _q_buff:String;
        protected var _q_cooldown_level:int;
        protected var _q_cooldown_type:int;
        protected var _q_transfer:int;
        protected var _q_transfer_map:int;
        protected var _q_transfer_position:int;
        protected var _q_task:uint;
        protected var _q_script:int;
        protected var _q_skill:int;
        protected var _q_gift:int;
        protected var _q_quality_lv:int;
        protected var _q_append:int;
        protected var _q_describe:String;
        protected var _q_item_icon:String;
        protected var _q_large_icon:String;
        protected var _q_equip_icon:String;
        protected var _q_drop_music:String;
        protected var _q_use_music:String;
        protected var _q_unuse_music:String;
        protected var _q_drop_animation:String;
        protected var _q_effict_type:String;
        protected var _q_effict_value:String;
        protected var _q_whether_batch:int;
        protected var _q_save_warehouse:Boolean;
        protected var _q_auto_use:Boolean;
        protected var _q_auto_getuse:Boolean;
        protected var _q_item_limit:int;
        protected var _q_valuable:Boolean;
        protected var _q_npc_drop:Boolean;
        protected var _q_can_die_drop:Boolean;
        protected var _q_max_endure:int;
        protected var _q_when_noendure:Boolean;
        protected var _q_can_break_moving:Boolean;
        protected var _q_can_make:Boolean;
        protected var _q_can_repair:Boolean;
        protected var _q_effective_time:uint;
        protected var _q_when_noeffective:Boolean;
        protected var _q_use_confirm:Boolean;
        protected var _q_ui:int;
        protected var _q_int_limit:int;
        protected var _q_vit_limit:int;
        protected var _q_equip_steplv:int;
        protected var name:String;
        private var _isMine:Boolean;
        private var _blongToMine:Boolean;
        protected var _unInteractive:Boolean;
        private var _q_remarkable:int;
        private var _q_lock:int;
        public var isUsing:Boolean;
        public var q_value:String;
        public var effectUrl:String;
        private var _goodAttributes:Vector.<GoodsAttribute>;
        public var suitId:int;
        private var _q_level:int;
        protected var _url:String;
        private var _q_sex:int;
        private var _q_job_limit:Number;

        public function PropInfo()
        {
            this._goodAttributes = new Vector.<GoodsAttribute>;
            return;
        }// end function

        public function get isMine() : Boolean
        {
            return this._isMine;
        }// end function

        public function set isMine(param1:Boolean) : void
        {
            this._isMine = param1;
            if (param1)
            {
                this.blongToMine = param1;
            }
            return;
        }// end function

        public function get blongToMine() : Boolean
        {
            return this._blongToMine;
        }// end function

        public function set blongToMine(param1:Boolean) : void
        {
            this._blongToMine = param1;
            return;
        }// end function

        public function get unInteractive() : Boolean
        {
            return this._unInteractive;
        }// end function

        public function set unInteractive(param1:Boolean) : void
        {
            this._unInteractive = param1;
            return;
        }// end function

        public function get shortcutId() : long
        {
            return this._shortcutId;
        }// end function

        public function set shortcutId(param1:long) : void
        {
            this._shortcutId = param1;
            return;
        }// end function

        public function get q_shortcut() : int
        {
            return this._q_shortcut;
        }// end function

        public function set q_shortcut(param1:int) : void
        {
            this._q_shortcut = param1;
            return;
        }// end function

        public function get q_vit_limit() : int
        {
            return this._q_vit_limit;
        }// end function

        public function set q_vit_limit(param1:int) : void
        {
            this._q_vit_limit = param1;
            return;
        }// end function

        public function get q_remarkable() : int
        {
            return this._q_remarkable;
        }// end function

        public function set q_remarkable(param1:int) : void
        {
            this._q_remarkable = param1;
            return;
        }// end function

        public function get q_int_limit() : int
        {
            return this._q_int_limit;
        }// end function

        public function set q_int_limit(param1:int) : void
        {
            this._q_int_limit = param1;
            return;
        }// end function

        public function get q_level() : int
        {
            return this._q_level;
        }// end function

        public function set q_level(param1:int) : void
        {
            this._q_level = param1;
            return;
        }// end function

        public function get q_effict_value() : String
        {
            return this._q_effict_value;
        }// end function

        public function get effictValues() : Array
        {
            var _loc_1:* = /\[.*?\]/gims;
            var _loc_2:* = _loc_1.exec(this._q_effict_value)[0];
            _loc_2 = _loc_2.substr(1, _loc_2.length - 2);
            return _loc_2.split(",");
        }// end function

        public function set q_effict_value(param1:String) : void
        {
            this._q_effict_value = param1;
            return;
        }// end function

        public function get q_use_confirm() : Boolean
        {
            return this._q_use_confirm;
        }// end function

        public function set q_use_confirm(param1:Boolean) : void
        {
            this._q_use_confirm = param1;
            return;
        }// end function

        public function get q_when_noeffective() : Boolean
        {
            return this._q_when_noeffective;
        }// end function

        public function set q_when_noeffective(param1:Boolean) : void
        {
            this._q_when_noeffective = param1;
            return;
        }// end function

        public function get q_effective_time() : uint
        {
            return this._q_effective_time;
        }// end function

        public function set q_effective_time(param1:uint) : void
        {
            this._q_effective_time = param1;
            return;
        }// end function

        public function get q_can_repair() : Boolean
        {
            return this._q_can_repair;
        }// end function

        public function set q_can_repair(param1:Boolean) : void
        {
            this._q_can_repair = param1;
            return;
        }// end function

        public function get q_can_make() : Boolean
        {
            return this._q_can_make;
        }// end function

        public function set q_can_make(param1:Boolean) : void
        {
            this._q_can_make = param1;
            return;
        }// end function

        public function get q_can_break_moving() : Boolean
        {
            return this._q_can_break_moving;
        }// end function

        public function set q_can_break_moving(param1:Boolean) : void
        {
            this._q_can_break_moving = param1;
            return;
        }// end function

        public function get q_when_noendure() : Boolean
        {
            return this._q_when_noendure;
        }// end function

        public function set q_when_noendure(param1:Boolean) : void
        {
            this._q_when_noendure = param1;
            return;
        }// end function

        public function get q_max_endure() : int
        {
            return this._q_max_endure;
        }// end function

        public function set q_max_endure(param1:int) : void
        {
            this._q_max_endure = param1;
            return;
        }// end function

        public function get q_can_die_drop() : Boolean
        {
            return this._q_can_die_drop;
        }// end function

        public function set q_can_die_drop(param1:Boolean) : void
        {
            this._q_can_die_drop = param1;
            return;
        }// end function

        public function get q_npc_drop() : Boolean
        {
            return this._q_npc_drop;
        }// end function

        public function set q_npc_drop(param1:Boolean) : void
        {
            this._q_npc_drop = param1;
            return;
        }// end function

        public function get q_valuable() : Boolean
        {
            return this._q_valuable;
        }// end function

        public function set q_valuable(param1:Boolean) : void
        {
            this._q_valuable = param1;
            return;
        }// end function

        public function get q_item_limit() : int
        {
            return this._q_item_limit;
        }// end function

        public function set q_item_limit(param1:int) : void
        {
            this._q_item_limit = param1;
            return;
        }// end function

        public function get q_save_warehouse() : Boolean
        {
            return this._q_save_warehouse;
        }// end function

        public function set q_save_warehouse(param1:Boolean) : void
        {
            this._q_save_warehouse = param1;
            return;
        }// end function

        public function get q_whether_batch() : int
        {
            return this._q_whether_batch;
        }// end function

        public function set q_whether_batch(param1:int) : void
        {
            this._q_whether_batch = param1;
            return;
        }// end function

        public function get q_auto_use() : Boolean
        {
            return this._q_auto_use;
        }// end function

        public function set q_auto_use(param1:Boolean) : void
        {
            this._q_auto_use = param1;
            return;
        }// end function

        public function get q_auto_getuse() : Boolean
        {
            return this._q_auto_getuse;
        }// end function

        public function set q_auto_getuse(param1:Boolean) : void
        {
            this._q_auto_getuse = param1;
            return;
        }// end function

        public function get q_effict_type() : String
        {
            return this._q_effict_type;
        }// end function

        public function set q_effict_type(param1:String) : void
        {
            this._q_effict_type = param1;
            return;
        }// end function

        public function get q_drop_animation() : String
        {
            return this._q_drop_animation;
        }// end function

        public function set q_drop_animation(param1:String) : void
        {
            this._q_drop_animation = param1;
            return;
        }// end function

        public function get q_unuse_music() : String
        {
            return this._q_unuse_music;
        }// end function

        public function set q_unuse_music(param1:String) : void
        {
            this._q_unuse_music = param1;
            return;
        }// end function

        public function get q_use_music() : String
        {
            return this._q_use_music;
        }// end function

        public function set q_use_music(param1:String) : void
        {
            this._q_use_music = param1;
            return;
        }// end function

        public function get q_drop_music() : String
        {
            return this._q_drop_music;
        }// end function

        public function set q_drop_music(param1:String) : void
        {
            this._q_drop_music = param1;
            return;
        }// end function

        public function get q_equip_icon() : String
        {
            return this._q_equip_icon;
        }// end function

        public function set q_equip_icon(param1:String) : void
        {
            this._q_equip_icon = param1;
            return;
        }// end function

        public function get q_large_icon() : String
        {
            return this._q_large_icon;
        }// end function

        public function set q_large_icon(param1:String) : void
        {
            this._q_large_icon = param1;
            return;
        }// end function

        public function get q_item_icon() : String
        {
            return this._q_item_icon;
        }// end function

        public function set q_item_icon(param1:String) : void
        {
            this._q_item_icon = param1;
            return;
        }// end function

        public function get q_describe() : String
        {
            return this._q_describe;
        }// end function

        public function set q_describe(param1:String) : void
        {
            if (param1.charAt(0) == "\"" && param1.charAt((param1.length - 1)) == "\"")
            {
                this._q_describe = param1.substring(1, (param1.length - 1));
            }
            else
            {
                this._q_describe = param1;
            }
            return;
        }// end function

        public function get q_append() : int
        {
            return this._q_append;
        }// end function

        public function set q_append(param1:int) : void
        {
            this._q_append = param1;
            return;
        }// end function

        public function get q_quality_lv() : int
        {
            return this._q_quality_lv;
        }// end function

        public function set q_quality_lv(param1:int) : void
        {
            this._q_quality_lv = param1;
            return;
        }// end function

        public function get q_gift() : int
        {
            return this._q_gift;
        }// end function

        public function set q_gift(param1:int) : void
        {
            this._q_gift = param1;
            return;
        }// end function

        public function get q_skill() : int
        {
            return this._q_skill;
        }// end function

        public function set q_skill(param1:int) : void
        {
            this._q_skill = param1;
            return;
        }// end function

        public function get q_script() : int
        {
            return this._q_script;
        }// end function

        public function set q_script(param1:int) : void
        {
            this._q_script = param1;
            return;
        }// end function

        public function get q_task() : uint
        {
            return this._q_task;
        }// end function

        public function set q_task(param1:uint) : void
        {
            this._q_task = param1;
            return;
        }// end function

        public function get q_transfer_position() : int
        {
            return this._q_transfer_position;
        }// end function

        public function set q_transfer_position(param1:int) : void
        {
            this._q_transfer_position = param1;
            return;
        }// end function

        public function get q_transfer_map() : int
        {
            return this._q_transfer_map;
        }// end function

        public function set q_transfer_map(param1:int) : void
        {
            this._q_transfer_map = param1;
            return;
        }// end function

        public function get q_transfer() : int
        {
            return this._q_transfer;
        }// end function

        public function set q_transfer(param1:int) : void
        {
            this._q_transfer = param1;
            return;
        }// end function

        public function get q_cooldown_type() : int
        {
            return this._q_cooldown_type;
        }// end function

        public function set q_cooldown_type(param1:int) : void
        {
            this._q_cooldown_type = param1;
            return;
        }// end function

        public function get q_cooldown_level() : int
        {
            return this._q_cooldown_level;
        }// end function

        public function set q_cooldown_level(param1:int) : void
        {
            this._q_cooldown_level = param1;
            return;
        }// end function

        public function get q_buff() : String
        {
            return this._q_buff;
        }// end function

        public function set q_buff(param1:String) : void
        {
            this._q_buff = param1;
            return;
        }// end function

        public function get q_drop_confirm() : Boolean
        {
            return this._q_drop_confirm;
        }// end function

        public function set q_drop_confirm(param1:Boolean) : void
        {
            this._q_drop_confirm = param1;
            return;
        }// end function

        public function get q_drop() : int
        {
            return this._q_drop;
        }// end function

        public function set q_drop(param1:int) : void
        {
            this._q_drop = param1;
            return;
        }// end function

        public function get q_sell_confirm() : Boolean
        {
            return this._q_sell_confirm;
        }// end function

        public function set q_sell_confirm(param1:Boolean) : void
        {
            this._q_sell_confirm = param1;
            return;
        }// end function

        public function get q_sell_price() : int
        {
            return this._q_sell_price;
        }// end function

        public function set q_sell_price(param1:int) : void
        {
            this._q_sell_price = param1;
            return;
        }// end function

        public function get q_sell() : int
        {
            return this._q_sell;
        }// end function

        public function set q_sell(param1:int) : void
        {
            this._q_sell = param1;
            return;
        }// end function

        public function get q_buy_price() : int
        {
            return this._q_buy_price;
        }// end function

        public function set q_buy_price(param1:int) : void
        {
            this._q_buy_price = param1;
            return;
        }// end function

        public function get q_max() : int
        {
            return this._q_max;
        }// end function

        public function set q_max(param1:int) : void
        {
            this._q_max = param1;
            return;
        }// end function

        public function get q_bind() : int
        {
            return this._q_bind;
        }// end function

        public function set q_bind(param1:int) : void
        {
            this._q_bind = param1;
            return;
        }// end function

        public function get q_agile_limit() : int
        {
            return this._q_agile_limit;
        }// end function

        public function set q_agile_limit(param1:int) : void
        {
            this._q_agile_limit = param1;
            return;
        }// end function

        public function get q_str_limit() : int
        {
            return this._q_str_limit;
        }// end function

        public function set q_str_limit(param1:int) : void
        {
            this._q_str_limit = param1;
            return;
        }// end function

        public function get q_job_limit() : Number
        {
            return this._q_job_limit;
        }// end function

        public function set q_job_limit(param1:Number) : void
        {
            this._q_job_limit = param1;
            return;
        }// end function

        public function get q_sex() : int
        {
            return this._q_sex;
        }// end function

        public function set q_sex(param1:int) : void
        {
            this._q_sex = param1;
            return;
        }// end function

        public function get q_ui() : int
        {
            return this._q_ui;
        }// end function

        public function set q_ui(param1:int) : void
        {
            this._q_ui = param1;
            return;
        }// end function

        public function get q_lock() : int
        {
            return this._q_lock;
        }// end function

        public function set q_lock(param1:int) : void
        {
            this._q_lock = param1;
            return;
        }// end function

        public function get q_type() : int
        {
            return this._q_type;
        }// end function

        public function set q_type(param1:int) : void
        {
            this._q_type = param1;
            return;
        }// end function

        public function get url() : String
        {
            return this._url;
        }// end function

        public function set url(param1:String) : void
        {
            this._url = param1;
            return;
        }// end function

        public function conv(param1:ItemInfo) : void
        {
            this._itemId = param1.itemId;
            this._itemModelId = param1.itemModelId;
            this.setAttribute(param1.goodAttributes);
            this.setAttributeCfg(ItemCfgObj.getInstance().getCfgBy(this._itemModelId));
            if (this.q_type == ItemType.ELEMENT_HEART)
            {
                this.effectUrl = QEHeartCfgObj.getInstance().getItem(int(this.q_value)).effectUrl;
            }
            this.num = param1.num;
            this._gridId = param1.gridId;
            this._isbind = param1.isbind;
            this.intensify = param1.intensify;
            this._addAttributLevel = param1.addAttributLevel;
            this._attribute = param1.attributs;
            this._isFullAppend = param1.isFullAppend;
            this._lostTime = param1.lostTime;
            this.suitId = param1.suitId;
            return;
        }// end function

        public function clone() : Object
        {
            var _loc_1:* = getQualifiedClassName(this);
            var _loc_2:* = _loc_1.split("::")[0];
            var _loc_3:* = getDefinitionByName(_loc_1) as Class;
            registerClassAlias(_loc_2, _loc_3);
            var _loc_4:* = new ByteArray();
            _loc_4.writeObject(this);
            _loc_4.position = 0;
            return _loc_4.readObject();
        }// end function

        public function convByObject(param1:Object) : void
        {
            var _loc_2:* = undefined;
            var _loc_3:* = 0;
            var _loc_4:* = 0;
            var _loc_5:* = null;
            if (!param1)
            {
                return;
            }
            for (_loc_2 in param1)
            {
                
                if (this.hasOwnProperty(_loc_2))
                {
                    if (_loc_2 == "goodAttributes")
                    {
                        this._goodAttributes = new Vector.<GoodsAttribute>;
                        _loc_3 = _loc_7.goodAttributes.length;
                        _loc_4 = 0;
                        while (_loc_4 < _loc_3)
                        {
                            
                            _loc_5 = new GoodsAttribute();
                            _loc_5.type = _loc_7.goodAttributes[_loc_4].type;
                            _loc_5.value = _loc_7.goodAttributes[_loc_4].value;
                            _loc_4++;
                        }
                        continue;
                    }
                    if (_loc_2 == "itemId")
                    {
                        this.itemId = new long();
                        this.itemId.high = _loc_7.itemId.high;
                        this.itemId.low = _loc_7.itemId.low;
                        continue;
                    }
                    this[_loc_2] = _loc_7[_loc_2];
                }
            }
            return;
        }// end function

        public function conByWorldMapDropInfo(param1:WorldMapDropInfo) : void
        {
            this.convByCfg(param1.itemModelId);
            return;
        }// end function

        private function setAttribute(param1:Vector.<GoodsAttribute>) : void
        {
            return;
        }// end function

        public function convByCfg(param1:int) : void
        {
            this._itemModelId = param1;
            this.setAttributeCfg(ItemCfgObj.getInstance().getCfgBy(param1));
            if (this.q_type == ItemType.ELEMENT_HEART)
            {
                this.effectUrl = QEHeartCfgObj.getInstance().getItem(int(this.q_value)).effectUrl;
            }
            return;
        }// end function

        protected function setAttributeCfg(param1:Object) : void
        {
            var _loc_2:* = undefined;
            if (!param1)
            {
                return;
            }
            for (_loc_2 in param1)
            {
                
                if (this.hasOwnProperty(_loc_2))
                {
                    this[_loc_2] = _loc_4[_loc_2];
                }
            }
            this.name = q_name;
            this.q_agile_limit = _loc_4.q_dex_limit;
            this._url = Params.ITEM_PATH + _loc_4.q_item_icon + ".png";
            this._q_auto_use = int(_loc_4.q_auto_use) == 0 ? (false) : (true);
            this._q_auto_getuse = int(_loc_4.q_auto_getuse) == 0 ? (false) : (true);
            parse(param1);
            return;
        }// end function

        public function setAttributeFromProInfo(param1:PropInfo) : void
        {
            this.num = param1.num;
            return;
        }// end function

        public function get itemId() : long
        {
            return this._itemId;
        }// end function

        public function isUseForJob(param1:Number) : Boolean
        {
            return PropUtil.canUseByJob(this.q_job_limit, param1);
        }// end function

        public function isUseForJobKind(param1:Number) : Boolean
        {
            return PropUtil.canUseByJobKind(this.q_job_limit, param1);
        }// end function

        public function set itemId(param1:long) : void
        {
            this._itemId = param1;
            return;
        }// end function

        public function get itemModelId() : int
        {
            return this._itemModelId;
        }// end function

        public function set itemModelId(param1:int) : void
        {
            this._itemModelId = param1;
            return;
        }// end function

        public function get num()
        {
            return this._num;
        }// end function

        public function set num(param1) : void
        {
            if (param1 is long)
            {
                this._num = (param1 as long).toNumber();
            }
            else
            {
                this._num = param1;
            }
            return;
        }// end function

        public function get gridId() : int
        {
            return this._gridId;
        }// end function

        public function set gridId(param1:int) : void
        {
            this._gridId = param1;
            return;
        }// end function

        public function get isbind() : int
        {
            return this._isbind;
        }// end function

        public function set isbind(param1:int) : void
        {
            this._isbind = param1;
            return;
        }// end function

        public function get intensify() : int
        {
            return streng;
        }// end function

        public function set intensify(param1:int) : void
        {
            streng = param1;
            return;
        }// end function

        public function get addAttributLevel() : int
        {
            return this._addAttributLevel;
        }// end function

        public function set addAttributLevel(param1:int) : void
        {
            this._addAttributLevel = param1;
            return;
        }// end function

        public function get attribute() : int
        {
            return this._attribute;
        }// end function

        public function set attribute(param1:int) : void
        {
            this._attribute = param1;
            return;
        }// end function

        public function get isFullAppend() : int
        {
            return this._isFullAppend;
        }// end function

        public function set isFullAppend(param1:int) : void
        {
            this._isFullAppend = param1;
            return;
        }// end function

        public function get lostTime() : int
        {
            return this._lostTime;
        }// end function

        public function set lostTime(param1:int) : void
        {
            this._lostTime = param1;
            return;
        }// end function

        public function get goodAttributes() : Vector.<GoodsAttribute>
        {
            return this._goodAttributes;
        }// end function

        public function set goodAttributes(param1:Vector.<GoodsAttribute>) : void
        {
            this._goodAttributes = param1;
            return;
        }// end function

        public function get isHighLocked() : Boolean
        {
            return this._lockedEndTime;
        }// end function

        public function get lockedEndTime() : int
        {
            return this._lockedEndTime;
        }// end function

        public function set lockedEndTime(param1:int) : void
        {
            this._lockedEndTime = param1;
            return;
        }// end function

    }
}
