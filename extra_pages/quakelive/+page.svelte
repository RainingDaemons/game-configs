<script lang="ts">
	import mapsRaw from './maps.txt?raw';

	type MapEntry = {
		name: string;
		modes: string[];
		workshopId: string;
	};

	const maps: MapEntry[] = mapsRaw
		.split('\n')
		.map((line) => line.trim())
		.filter(Boolean)
		.map((line) => {
			const [name = '', modes = '', workshopId = ''] = line.split('|');
			return {
				name,
				modes: modes
					.split(',')
					.map((m) => m.trim())
					.filter(Boolean),
				workshopId
			};
		});

	const imageUrls = import.meta.glob('./images/*', {
		eager: true,
		import: 'default'
	}) as Record<string, string>;

	const failed = $state<Record<string, boolean>>({});

	function imageFor(name: string): string | undefined {
		return imageUrls[`./images/${name}.jpg`];
	}

	function workshopUrl(id: string): string {
		return `https://steamcommunity.com/sharedfiles/filedetails/?id=${id}`;
	}
</script>

<div class="rounded-xl border border-neutral-800 bg-neutral-900 p-5">
	<h2 class="text-lg font-medium">Installed Maps in Server</h2>
	<p class="mt-1 text-sm text-neutral-400">{maps.length} maps</p>

	<div class="mt-4 grid grid-cols-1 gap-4 sm:grid-cols-2 lg:grid-cols-3">
		{#each maps as map (map.name)}
			{@const src = imageFor(map.name)}
			<div class="overflow-hidden rounded-xl border border-neutral-800 bg-neutral-950">
				{#if src && !failed[map.name]}
					<img
						src={src}
						alt={map.name}
						class="h-40 w-full object-cover"
						onerror={() => {
							failed[map.name] = true;
						}}
					/>
				{:else}
					<div
						class="flex h-40 w-full flex-col items-center justify-center gap-2 text-neutral-500"
					>
						<svg
							xmlns="http://www.w3.org/2000/svg"
							width="32"
							height="32"
							viewBox="0 0 24 24"
							fill="none"
							stroke="currentColor"
							stroke-width="2"
							stroke-linecap="round"
							stroke-linejoin="round"
						>
							<rect x="3" y="3" width="18" height="18" rx="2" ry="2"></rect>
							<circle cx="9" cy="9" r="2"></circle>
							<path d="m21 15-3.086-3.086a2 2 0 0 0-2.828 0L6 21"></path>
						</svg>
						<span class="text-sm">No image available</span>
					</div>
				{/if}

				<div class="p-4">
					<h3 class="font-medium">{map.name}</h3>
					<div class="mt-2 flex flex-wrap gap-1">
						{#each map.modes as mode}
							<span
								class="rounded bg-neutral-800 px-2 py-0.5 text-xs uppercase text-neutral-300"
							>
								{mode}
							</span>
						{/each}
					</div>
					<div class="mt-3 text-sm text-neutral-400">
						{#if map.workshopId !== '0'}
							<a
								href={workshopUrl(map.workshopId)}
								target="_blank"
								rel="noreferrer"
								class="text-blue-400 hover:text-blue-300 hover:underline"
							>
								Workshop ID: {map.workshopId}
							</a>
						{:else}
							<span class="text-neutral-500">Vanilla</span>
						{/if}
					</div>
				</div>
			</div>
		{/each}
	</div>
</div>
