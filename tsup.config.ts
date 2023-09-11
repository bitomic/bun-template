import { defineConfig } from 'tsup'

export default defineConfig( {
	bundle: true,
	clean: true,
	dts: false,
	entry: [ 'src/**/*.ts', '!src/**/*.d.ts' ],
	format: [ 'esm', 'cjs' ],
	keepNames: true,
	minify: false,
	shims: false,
	skipNodeModulesBundle: true,
	sourcemap: true,
	splitting: false,
	target: 'esnext',
	tsconfig: 'tsconfig.json'
} )
