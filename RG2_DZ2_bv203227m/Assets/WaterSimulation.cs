using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class WaterSimulation : MonoBehaviour
{
    [SerializeField]
    CustomRenderTexture texture;

    // Start is called before the first frame update
    void Start()
    {
        texture.Initialize();
    }

    // Update is called once per frame
    void Update()
    {
        texture.ClearUpdateZones();

        texture.Update();
    }

    void UpdateZones()
    {
        
    }
}
