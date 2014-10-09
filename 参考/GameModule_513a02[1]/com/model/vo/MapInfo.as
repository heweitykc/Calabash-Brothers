package com.model.vo
{
    import com.staticdata.*;

    public class MapInfo extends Object
    {
        public var mapId:uint;
        public var url:String;
        public var mapWidth:uint;
        public var mapHeight:uint;
        public var worldmapSort:uint;
        public var mapName:String;
        public var mapLimitMinLv:int;
        public var mapLimitMaxLv:int;
        public var mapTransforCost:int;
        public var mapZones:int;
        public var dieX:uint;
        public var dieY:uint;
        public var zones_type:uint;
        public var q_map_safe:int;
        public var q_light_intensity:int;
        public var q_music:String;
        public var q_map_pk:int;
        public var q_max_online:int;
        public var q_battle_type:int;
        public var q_line_control:int;

        public function MapInfo(param1:Object)
        {
            if (param1)
            {
                this.mapId = param1.q_map_id;
                this.url = param1.q_mapresid;
                this.mapWidth = param1.q_map_width;
                this.mapHeight = param1.q_map_height;
                this.worldmapSort = param1.q_worldmap_sort;
                this.mapName = param1.q_map_name;
                this.mapLimitMinLv = param1.q_map_min_level;
                this.mapLimitMaxLv = param1.q_map_max_level;
                this.mapTransforCost = param1.q_transfer_money;
                this.mapZones = param1.q_map_zones;
                if (this.mapId == Params.BOSS_HOME_CITY_MAP)
                {
                    this.mapZones = 1;
                }
                this.dieX = param1.q_map_die_x;
                this.dieY = param1.q_map_die_y;
                this.zones_type = param1.q_zones_type;
                this.q_map_safe = param1.q_map_safe;
                this.q_light_intensity = param1.q_light_intensity;
                this.q_music = param1.q_music;
                this.q_map_pk = param1.q_map_pk;
                this.q_battle_type = param1.q_battle_type;
                this.q_max_online = param1.q_max_online;
                this.q_line_control = param1.q_line_control;
            }
            return;
        }// end function

    }
}
