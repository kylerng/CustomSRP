﻿Shader "Hidden/CustomSRP/SRP0803/copyColor"
{
    Properties
    {
    }

    SubShader
    {
        Pass
        {
            Name "FinalColor"

            // No culling or depth
            Cull Off ZWrite Off ZTest Always
	
			CGPROGRAM
			#pragma vertex vert
			#pragma fragment frag

			#include "UnityCG.cginc"
			#include "HLSLSupport.cginc"

			struct appdata
			{
				float4 vertex : POSITION;
				float2 uv : TEXCOORD;
			};

			struct v2f
			{
				float4 vertex : SV_POSITION;
				float2 uv : TEXCOORD;
			};

			v2f vert (appdata v)
			{
				v2f o;
				o.vertex = UnityObjectToClipPos(v.vertex);
				o.uv = v.uv;
				return o;
			}
			
			sampler2D _CameraAlbedoTexture;
			sampler2D _CameraEmissionTexture;

			float4 frag (v2f i) : SV_Target
			{
				float4 albedo = tex2D(_CameraAlbedoTexture, i.uv);
				float4 emission = tex2D(_CameraEmissionTexture, i.uv);

				return albedo + emission;
			}
			ENDCG
        }
    }
}