#pragma once

#include <stdint.h>
#include <stddef.h>

#ifdef __cplusplus
extern "C" {
#endif

typedef void* EngineHandle;

/* Ada runtime */
void ada_runtime_init(void);

/* Engine lifecycle */
size_t core_state_size(void);
void   core_init(EngineHandle h);
void   core_step(EngineHandle h);
int32_t core_value(EngineHandle h);

#ifdef __cplusplus
}
#endif
