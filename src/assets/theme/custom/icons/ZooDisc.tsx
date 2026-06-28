import { Box, BoxProps } from '@chakra-ui/react';

// Zoo brand mark: the iridescent additive (RGB) Venn disc with a white
// center, matching the live zoo.ngo mark. Multi-color, so it is a real SVG
// wrapped in a Chakra Box (rather than a single-color createIcon) — all
// Chakra layout props (boxSize, mr, ...) pass straight through.
export function ZooDisc(props: BoxProps) {
  return (
    <Box lineHeight="0" {...props}>
      <svg
        viewBox="0 0 1024 1024"
        width="100%"
        height="100%"
        xmlns="http://www.w3.org/2000/svg"
        role="img"
        aria-label="Zoo"
      >
        <defs>
          <clipPath id="zd-disc">
            <circle cx="512" cy="511" r="500" />
          </clipPath>
          <clipPath id="zd-top">
            <circle cx="512" cy="250" r="430" />
          </clipPath>
          <clipPath id="zd-ll">
            <circle cx="240" cy="670" r="430" />
          </clipPath>
        </defs>
        <g clipPath="url(#zd-disc)">
          <circle cx="512" cy="250" r="430" fill="#00A652" />
          <circle cx="240" cy="670" r="430" fill="#ED1C24" />
          <circle cx="784" cy="670" r="430" fill="#2E3192" />
          <g clipPath="url(#zd-top)">
            <circle cx="240" cy="670" r="430" fill="#FCF006" />
          </g>
          <g clipPath="url(#zd-top)">
            <circle cx="784" cy="670" r="430" fill="#01ACF1" />
          </g>
          <g clipPath="url(#zd-ll)">
            <circle cx="784" cy="670" r="430" fill="#EA018E" />
          </g>
          <g clipPath="url(#zd-top)">
            <g clipPath="url(#zd-ll)">
              <circle cx="784" cy="670" r="430" fill="#FFFFFF" />
            </g>
          </g>
        </g>
      </svg>
    </Box>
  );
}
